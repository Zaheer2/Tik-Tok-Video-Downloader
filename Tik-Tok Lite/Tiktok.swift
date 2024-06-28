//
//  TikTokData.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 10.04.2022.
//

import SwiftUI
import Photos
import AVKit
import AVFoundation

struct Tiktok: Identifiable {
    var id = UUID().uuidString
    var data: Welcome? = nil
    var name: String
    var fileName: String
    var coverFile: String
    var dataFile: String
    var player: AVPlayer?
    
    enum fileType {
        case data
        case video
        case cover
    }
    
    init(withFileName: String, withData: Welcome? = nil) {
        name = withFileName
        fileName = "\(withFileName).mp4"
        coverFile = "\(withFileName).jpg"
        dataFile = "\(withFileName).json"
        if withData == nil {
            let path = Constant.createURL(to: dataFile, in: .tiktokData)
            if let data = try? Data(contentsOf: path) {
                let decoder = JSONDecoder()
                do {
                    self.data = try decoder.decode(
                        Welcome.self,
                        from: data)
                } catch {
                    print("Error decoding item array: \(error.localizedDescription)")
                }
            }
        } else {
            data = withData
        }
    }
    
    public func url(forFile: fileType) -> URL {
        switch forFile {
        case .video:
            return Constant.createURL(to: fileName, in: .tiktokVideo)
        case .data:
            return Constant.createURL(to: dataFile, in: .tiktokData)
        case .cover:
            return Constant.createURL(to: coverFile, in: .tiktokCovers)
        }
    }
    
    public func loadCover() -> UIImage? {
        let path = Constant.createURL(to: coverFile, in: .tiktokCovers)
            do {
                let imageData = try Data(contentsOf: path)
                return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
            return nil
    }
    
    public func delete() {
        do {
            try FileManager.default.removeItem(at: self.url(forFile: .video))
            try FileManager.default.removeItem(at: self.url(forFile: .data))
            try FileManager.default.removeItem(at: self.url(forFile: .cover))
        } catch {
            print("Could not delete file: \(error)")
        }
    }
}
