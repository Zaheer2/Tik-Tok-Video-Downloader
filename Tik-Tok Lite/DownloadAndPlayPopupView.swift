//
//  ModalPopUpView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 29.12.2021.
//

import SwiftUI
import AVKit

struct DownloadAndPlayPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageModel: StorageModel
    
    @State private var isplaying = false
    @State private var isSaved = false
    @State private var presentAlert = false
    @State private var showcontrols = false
    @State private var sliderValue = 0.0
    @State private var value: Float = 0
    @State private var observer: Any?
    
    @State var player: AVPlayer
    
    var body: some View {
        VStack {
            HStack {
                Text("Download video")
                    .bold()
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 10)
            
            ZStack {
                VideoPlayer(player: $player)
                    .frame(width: Constant.Size.videoPlayerWidth, height: Constant.Size.videoPlayerHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(radius: 7)
                    .onTapGesture { showcontrols.toggle() }
                
                if showcontrols {
                    ZStack {
                        VStack {
                            Spacer()
                            Button(action: {
                                if isplaying {
                                    player.pause()
                                    isplaying = false
                                } else {
                                    player.play()
                                    isplaying = true
                                }
                            }) { Image(isplaying ? "PauseCircle" : "PlayCircle").scaleEffect(0.6) }
                            
                            Spacer()
                            
                            Slider(
                                value: $sliderValue,
                                in: 0...1,
                                onEditingChanged: { editing in
                                    player.pause()
                                    player.seek(to: CMTime(seconds: (player.currentItem?.duration.seconds)! * sliderValue, preferredTimescale: 1))
                                    player.play()
                                }
                            )
                                .accentColor(.roseColor)
                                .padding(.bottom, 30)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            
            Button(action: {
                isSaved = true
                if !storageModel.playlistArray.isEmpty {
                    storageModel.add(video: storageModel.tiktokTemp!, to: 0)
                }
                presentAlert = true
            }) {
                makeMainButtonLabel(image: "arrow.down.doc.fill", text: "Download clip", isReversed: false, color: .rose)
            }
            .mainButtonStyle(color: .rose)
            .padding([.top, .bottom], 10)
            
            Button(action: { closeView() }) {
                    makeMainButtonLabel(image: "star.fill", text: "Add to playlist", isReversed: false, color: .rose)
                }
                .mainButtonStyle(color: .rose)
            Spacer()
        }
        .alert("Attention",
               isPresented: $presentAlert,
               actions: { Button("Ok") { closeView() }},
               message: { Text("Video saved in your gallery") })
        .background(Color.clear.edgesIgnoringSafeArea(.all))
        .onAppear {
            isSaved = false
            observer = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: .main) { (_) in
                sliderValue = Double(player.currentTime().seconds / (player.currentItem?.duration.seconds)!)
                if sliderValue >= 0.99{
                    player.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
                    player.play()
                    player.play()
                }
            }
            player.play()
            isplaying = true
        }
        .onDisappear() {
            if !isSaved {
                if let tiktokTemp = storageModel.tiktokTemp { tiktokTemp.delete() }
            }
            player.removeTimeObserver(observer!)
            player.replaceCurrentItem(with: nil)
            closeView()
        }
    }
    
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}
