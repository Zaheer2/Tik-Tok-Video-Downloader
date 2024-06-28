//
//  PlaylistData.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.01.2022.
//

import SwiftUI

struct PlaylistData: Codable, Hashable {
    var name: String = ""
    var description: String = ""
    var videoArr: [String] = []
    
    public func loadCover() -> UIImage? {
        let coverFile = "\(name).jpg"
        let path = Constant.createURL(to: coverFile, in: .playlistData)
            do {
                let imageData = try Data(contentsOf: path)
                return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
            return nil
    }
}
