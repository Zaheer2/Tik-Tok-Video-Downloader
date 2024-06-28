//
//  PlaylistsStorage.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 09.04.2022.
//

import SwiftUI

final class StorageModel: ObservableObject {
    @Published var playlistArray: [PlaylistData] = []
    @Published var tiktokTemp: Tiktok? = nil
    
    init() {
        createDir()
        loadPlaylistData()
        checkDefaultPlaylist()
    }
    
    public func getIndexOfPlaylist(name: String) -> Int? {
        return playlistArray.firstIndex(where: {$0.name == name})
    }
    
    public func isExistPlaylistWith(name: String) -> Bool {
        var answer = false
        for playlist in playlistArray {
            if playlist.name == name {
                answer = true
                break
            }
        }
        return answer
    }
    
    public func deleteVideo(by index: Int, from playlistIndex: Int, isFromDisk: Bool) {
        if isFromDisk {
            let tiktokName = playlistArray[playlistIndex].videoArr[index]
            for arrayIndex in playlistArray.indices {
                if let index = playlistArray[arrayIndex].videoArr.firstIndex(of: tiktokName){
                    playlistArray[arrayIndex].videoArr.remove(at: index)
                }
            }
            let tiktok = Tiktok(withFileName: tiktokName)
            tiktok.delete()
        } else {
            playlistArray[playlistIndex].videoArr.remove(at: index)
        }
        savePlaylistData()
    }
    
    public func deletePlaylist(index: Int) {
        if index != 0 {
            UIImage.remove(filename: playlistArray[index].name, directory: .playlistData)
            playlistArray.remove(at: index)
            savePlaylistData()
        }
    }
    
    public func savePlaylist(at index: Int?, plistName: String, plistDiscription: String, image: UIImage?) {
        if plistName != "" {
            var newIndex = 0
            if index == nil {
                newIndex = playlistArray.endIndex
                playlistArray.append(PlaylistData(name: plistName, description: plistDiscription ))
            } else {
                newIndex = index!
                let videoArr = playlistArray[newIndex].videoArr
                playlistArray[newIndex] = PlaylistData(name: plistName,
                                                       description: plistDiscription,
                                                       videoArr: videoArr)
            }
            
            if let image = image {
                image.save(to: "\(plistName).jpg", directory: .playlistData)
            }
            savePlaylistData()
        }
    }
    
    public func add(video: Tiktok, to playlistIndex: Int?) {
        if let playlistIndex = playlistIndex {
            if playlistIndex == 0 {
                self.playlistArray[playlistIndex].videoArr.append(video.name)
            } else {
                self.playlistArray[playlistIndex].videoArr.append(video.name)
                self.playlistArray[0].videoArr.append(video.name)
            }
            savePlaylistData()
        }
    }
    
//        func addTikTok(_ video: , to playlist: String) {
//            let newItem = self.downloader.TikDataTemp.last!
//
//            let index = playlistArray.firstIndex(of: playlist)
//            playlistArray[index].append(newItem.fileName)
//            dataStorage
//            savePlaylistArray(downloader.playlistArray)
//            self.downloader.TikData.append(newItem)
//        }
    
    
    public func createDir() {
        do {
            try FileManager.default.createDirectory(at: Constant.getURL(for: .tiktokVideo), withIntermediateDirectories: true)
            try FileManager.default.createDirectory(at: Constant.getURL(for: .tiktokData), withIntermediateDirectories: true)
            try FileManager.default.createDirectory(at: Constant.getURL(for: .tiktokCovers), withIntermediateDirectories: true)
            try FileManager.default.createDirectory(at: Constant.getURL(for: .playlistData), withIntermediateDirectories: true)
            print("TikTok folder: \(Constant.getURL(for: .tiktokVideo))")
        } catch { }
    }
    
    func loadPlaylistData() {
        if let data = try? Data(contentsOf: Constant.URLconstant.dataJsonPath) {
            let decoder = JSONDecoder()
            do {
                playlistArray = try decoder.decode([PlaylistData].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
            for data in playlistArray {
                print(data.videoArr.count)
            }
        }
    }
    
    private func savePlaylistData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(playlistArray)
            try data.write(to: Constant.URLconstant.dataJsonPath, options: Data.WritingOptions.atomic)
        } catch { // 6
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    private func checkDefaultPlaylist() {
        let defaultPlaylist = PlaylistData(name: Constant.Name.defaultPlaylistName)
        if playlistArray.isEmpty || playlistArray[0].name != defaultPlaylist.name {
            playlistArray.insert(defaultPlaylist, at: 0)
            //  listCover.insert(nil, at: 0)
            savePlaylistData()
        }
        loadDefaultPlaylist()
    }
    
    private func loadDefaultPlaylist() {
        let fileManager = FileManager.default
        playlistArray[0].videoArr = []
        do {
            let items = try fileManager.contentsOfDirectory(atPath: Constant.getURL(for: .tiktokVideo).path)
            print("find some yummy")
            for item in items {
                if item.hasSuffix(".mp4") {
                    print("Found \(item)")
                    var name = item
                    name.removeLast(4)
                    playlistArray[0].videoArr.append(name)
                    
                }
            }
        } catch {
            print("fail to read the dir")
        }
    }
}
