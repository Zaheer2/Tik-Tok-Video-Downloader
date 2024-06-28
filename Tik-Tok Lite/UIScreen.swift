//
//  UIScreen.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 07.04.2022.
//

import SwiftUI
import UIKit

extension UIScreen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let size = UIScreen.main.bounds.size
    static var statusBarHeight: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
