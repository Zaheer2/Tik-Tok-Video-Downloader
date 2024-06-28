//
//  Downloader.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 16.01.2022.
//

import SwiftUI
import AVKit
import AVFoundation

struct Welcome: Codable {
    let id: String
    let createTime: String
    let desc: String
    let video: Video
    
    struct Video: Codable {
        let playAddr: String
        let downloadAddr: String
        let cover: String
    }
}

final class Downloader {
    
    static func downloadTikTok(by videoUrl: String) async throws -> Tiktok {
        guard let url = URL(string: videoUrl) else {
            throw "Could not create the URL."
        }
        
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15", forHTTPHeaderField: "User-Agent")
        request.setValue("https://www.tiktok.com/", forHTTPHeaderField: "Referer")
        request.setValue("bytes=0-", forHTTPHeaderField: "Range")
        print(request)
        
        let (data, response) = try await
        URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error."
        }
        
        print("Data: \(data)")
        
        func scrapJson(content: String) -> String? {
            var json: String?
            var jsond = content.components(separatedBy: "\"ItemModule\":")
            
            if jsond.indices.contains(1) {
                let jsonTemp = jsond[1]
                
                if let i = jsonTemp.firstIndex(of: "i") {
                    jsond[1] = String(jsonTemp.suffix(from: i))
                    jsond[1] = "{\"" +  jsond[1]
                }
                
                jsond = jsond[1].components(separatedBy: "},\"UserModule\"")
                if jsond.indices.contains(0) {
                    json = jsond[0]
                } else { json = nil }
                
            } else { json = nil }
            return json
        }
        
        
        let html = String(data: data, encoding: .utf8)!
        guard let json = scrapJson(content: html) else {
            throw "Scrap error."
        }
        
        let newData = String(json).data(using: .utf8)!
        let dot: Welcome?
        do {
            dot = try JSONDecoder().decode(Welcome.self, from: newData)
        } catch {
            throw "JsonParseFailed"
        }
        
        guard let dot = dot else {
            throw "JsonParseFailed"
        }
        
        let videoId = dot.id
        let videoCreatedTime = dot.createTime
        
        let dataFile = "\(videoId)-\(videoCreatedTime).json"
        let dataFileURL: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(dataFile)")
        let jsonData = try! JSONEncoder().encode(dot)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        try! jsonString.write(to: dataFileURL, atomically: true, encoding: .utf8)
        let dlAddr = dot.video.downloadAddr
        print("Download adrr: \(dlAddr)")
        
        request.url = URL(string: dlAddr)!
        print("start url session")
        
        let (videoData, videoResponse) = try await URLSession.shared.data(for: request)
        
        guard (videoResponse as? HTTPURLResponse)?.statusCode == 206 else {
            throw "The server responded with an error."
        }
        let fileName = "\(videoId)-\(videoCreatedTime).mp4"
        let fileURL: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/\(fileName)")
        print(fileURL)
        print("downloading \(fileName)")
        do {
            try videoData.write(to: fileURL)
        } catch {
            throw "Video save failed"
        }
        
        print("Video is saved")
        
        let coverAddr = dot.video.cover
        request.url = URL(string: coverAddr)!
        let (imageData, imageResponse) = try await URLSession.shared.data(for: request)
        
        let coverFile = "\(videoId)-\(videoCreatedTime).jpg"
        print("downloading cover\(coverFile)")
        
        guard (imageResponse as? HTTPURLResponse)?.statusCode == 206 else {
            throw "Cover download end with an error."
        }
        
        if let image = UIImage(data: imageData) {
            image.save(to: coverFile, directory: .tiktokCovers)
        }
        
        print("all ended")
        Notification.videoDownloadWasSuccessful()
        return Tiktok(withFileName: "\(videoId)-\(videoCreatedTime)", withData: dot)
    }
}

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}

