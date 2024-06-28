//
//  FilledPlaylistsTabView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 10.04.2022.
//

import SwiftUI

struct FilledPlaylistsTabView: View {
    @EnvironmentObject var storageModel: StorageModel
    
    @Binding var selection: Int?
    @Binding var index: Int?
    @Binding var showEditView: Bool
    
    var body: some View {
        List() {
            ForEach(storageModel.playlistArray.indices, id: \.self) { index in
                if index != 0 {
                ZStack {
                    NavigationLink(destination: PlaylistVideoListView( playlistIndex: index),
                                   tag: index,
                                   selection: $selection) {
                        EmptyView()
                    }
                    .opacity(0.001)
                    Button { selection = index } label: {
                        PlaylistIconView(playlist: storageModel.playlistArray[index])
                            .frame(width: Constant.Size.iconWidth)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .contextMenu { contextmenuButtons(index: index) }
                }
                .listRowBackground(Color.black)
                .listRowInsets(EdgeInsets())
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive, action: {
                        deletePlaylistAt(index: index)
                    }) { Label("Delete", systemImage: "trash") }
                }
                .tint(.roseColor)
            }
            }
        }
        .listStyle(.plain)
    }
    
    //MARK: ContextmenuButtons
    
    func contextmenuButtons(index: Int) -> some View {
        Group {
            Button {
                withAnimation {
                    self.index = index
                    showEditView = true
                }
            } label: { Label("Edit", systemImage: "pencil") }
            
            Button(role: .destructive) {
                withAnimation {
                    deletePlaylistAt(index: index)
                }
            } label: { Label("Delete", systemImage: "trash") }
        }
    }
    
    func deletePlaylistAt(index: Int) {
        storageModel.deletePlaylist(index: index)
    }
}

struct FilledPlaylistsTabView_Previews: PreviewProvider {
    static var previews: some View {
        FilledPlaylistsTabView(selection: .constant(nil),
                               index: .constant(nil),
                               showEditView: .constant(false))
            .environmentObject(StorageModel())
            .preferredColorScheme(.dark)
    }
}
