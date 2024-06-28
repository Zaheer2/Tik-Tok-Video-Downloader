//
//  Filemanager.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 07.04.2022.
//

import Foundation

extension FileManager {
    static func documentsDirectory() -> URL {
       let paths = FileManager.default.urls(
         for: .documentDirectory,
         in: .userDomainMask)
       return paths[0]
     }
}
