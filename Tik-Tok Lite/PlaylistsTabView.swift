//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct PlaylistsTabView : View {
    @Environment(\.presentationMode) var PlayListPresentationMode
    @EnvironmentObject var dataStorage: StorageModel
    
    @State private var selection: Int? = nil
    @State private var index: Int? = nil
    @State private var showEditView = false
    @State private var image: UIImage?
    @State private var listCovers: [UIImage?] = []
    @State private var showPlaylists: String = "playlists"
    
    @Binding var showDownloadFromPlaylistPopUpView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                if showPlaylists == "videos" {
                    PlaylistVideoListView( playlistIndex: 0)
                } else {
                NavigationLink(destination: PlaylistCreationView(index: index), isActive: $showEditView)
                { EmptyView() }
                Color.black
                EmptyPlaylistsTabView(index: $index)
                    .opacity(dataStorage.playlistArray.count == 1 ? 1 : 0)
                
                FilledPlaylistsTabView(selection: $selection,
                                       index: $index,
                                       showEditView: $showEditView)
                    .opacity(dataStorage.playlistArray.count == 1 ? 0 : 1)
            }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addPlistButton
                        .opacity(showPlaylists == "videos" ? 0 : 1)
                }
                ToolbarItem(placement: .navigationBarLeading) { picker }
            })
            .navigationTitle("Playlists")
            .mainTextStyle
        }
    }
    
    var addPlistButton: some View {
        Button {
            index = nil
            self.showEditView = true
        } label: { Image("Plus").foregroundColor(.roseColor) }
    }
    
    var picker: some View {
        Picker(selection: $showPlaylists) {
            Text("Videos").tag("videos")
            Text("Playlists").tag("playlists")
        } label: { }
        .pickerStyle(.inline)
        .frame(maxWidth: 130)
    }
}

struct PlaylistsTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsTabView(showDownloadFromPlaylistPopUpView: .constant(false))
            .environmentObject(StorageModel())
            .preferredColorScheme(.dark)
    }
}
