//
//  Player.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.04.2022.
//

import SwiftUI
import UIKit
import AVKit

struct VideoPlayer : UIViewControllerRepresentable {
    @Binding var player : AVPlayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayer>) { }
}
