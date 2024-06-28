//
//  PlayListVideoListView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 22.12.2021.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlaylistVideoListView: View {
    @EnvironmentObject var storageModel: StorageModel
    
    @State  var showingPlayerView = false
    @State  var playlistIndex: Int
    @State  var showDownloadPopUpView = false
    @State  var videolistArray: [Tiktok] = []
    @State  var videoForPlay = ""
    @State  private var runLoading = false
   
    var body: some View {
        VStack {
            if videolistArray.isEmpty {
                Image("Play")
                    .padding(5)
                Text("It's empty for now")
                    .montserrat16TextStyle
                    .padding(.bottom, 10)
                Text("Add video to playlist")
                    .montserrat16TextStyle
                    .foregroundColor(.white)
                
            } else {
                List() {
                    ForEach(videolistArray.indices, id: \.self) { index in
                            Button {
                                videoForPlay = videolistArray[index].fileName
                                showingPlayerView = true
                            } label: {
                                VideoIconView(tiktok: $videolistArray[index])
                            }
                            .foregroundColor(.white)
                            .buttonStyle(PlainButtonStyle())
                            .contextMenu(menuItems: {
                                Button(role: .destructive) {
                                    withAnimation { delete(index: index) }
                                } label: { Label("Delete", systemImage: "trash") }
                            })
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive, action: {
                                    delete(index: index)
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .tint(.roseColor)
                        }
                        .listRowBackground(Color.black)
                        .listRowInsets(EdgeInsets())
                    }
                .listStyle(.plain)
            }
        }
        .navigationBarItems(trailing: addNewVideoButton)
        .navigationTitle(storageModel.playlistArray[playlistIndex].name)
        .mainTextStyle
        .onChange(of: storageModel.playlistArray[playlistIndex].videoArr, perform: { videos in
            loadVideo(from: videos)
        })
        .onAppear() {
            let videos = storageModel.playlistArray[playlistIndex].videoArr
            loadVideo(from: videos)
        }
        .fullScreenCover(isPresented: $showingPlayerView) {
            PlayerView(currentVideo: videoForPlay, playlistArray: $videolistArray, videoToPlay: $videoForPlay)
        }
    }
    
    //MARK: addPlistButton
    
    var addNewVideoButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                showDownloadPopUpView = true
            }
        }){
            Image("Plus").foregroundColor(.roseColor)
        }
        .fullScreenCover(isPresented: $showDownloadPopUpView) {
            DownloadAddClipPopupView(runLoading: $runLoading)
        }
        .fullScreenCover(isPresented: $runLoading) {
            DownloadAnimationPopupView(playlistIndex: playlistIndex)
        }
    }
    
    func loadVideo(from array: [String]) {
        videolistArray = []
        for name in array {
            let tiktok = Tiktok(withFileName: name)
            videolistArray.append(tiktok)
        }
    }
    
    func delete(index: Int) {
        storageModel.deleteVideo(by: index, from: playlistIndex, isFromDisk: true)
        videolistArray.remove(at: index)
    }
}
