//
//  Settings.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 07.04.2022.
//

import SwiftUI

enum Directory {
    case playlistData
    case tiktokVideo
    case tiktokData
    case tiktokCovers
}

struct Constant {
    struct Size {
        static let splashImageSize: CGFloat = 120
        static let playlistDescriptionTextEditorHeight: CGFloat = UIScreen.height * 0.2
        static let cornerRadius: CGFloat = 10
        static let mainButtonsWidth: CGFloat = UIScreen.width * 0.92
        static let mainButtonsHeight: CGFloat = 53
       
        static let promoImagesWidth: CGFloat = UIScreen.width * 0.56
        static let iconWidth: CGFloat = UIScreen.width * 0.96
        static let defaultElementSize = CGSize(width: 800, height: 800)
        
        static let popupViewHeight: CGFloat = UIScreen.height * 0.33
        static let popupViewCornerRadius: CGFloat = 22
        
        static let videoPlayerWidth: CGFloat = UIScreen.width * 0.93
        static let videoPlayerHeight: CGFloat = UIScreen.height * 0.8 - 2 * mainButtonsHeight
        static let videoPlayerPlayButtomSize: CGFloat = 30
    }
    
    struct Name {
        static let defaultPlaylistName: String = "All files"
    }
    
    struct URLconstant {
        static let dataJsonPath: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/playlist/playlisData.json")
    }
    
    static func getURL(for directory: Directory) -> URL {
        switch directory {
        case .playlistData: return FileManager.documentsDirectory().appendingPathComponent("tiktoks/playlist")
        case .tiktokVideo: return FileManager.documentsDirectory().appendingPathComponent("tiktoks")
        case .tiktokData: return FileManager.documentsDirectory().appendingPathComponent("tiktoks/data")
        case .tiktokCovers: return FileManager.documentsDirectory().appendingPathComponent("tiktoks/covers")
        }
    }
    
    static func createURL(to file: String, in directory: Directory) -> URL {
        switch directory {
        case .playlistData: return FileManager.documentsDirectory().appendingPathComponent("tiktoks/playlist/\(file)")
        case .tiktokVideo: return FileManager.documentsDirectory().appendingPathComponent("tiktoks/\(file)")
        case .tiktokData: return FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(file)")
        case .tiktokCovers: return FileManager.documentsDirectory().appendingPathComponent("tiktoks/covers/\(file)")
        }
    }
}
