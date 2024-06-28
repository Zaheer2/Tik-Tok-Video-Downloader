//
//  Playlist.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 21.12.2021.
//

import SwiftUI

struct PlaylistIconView: View {
    @EnvironmentObject var dataStorage: StorageModel
    @State var image: UIImage? = nil
    
    let playlist: PlaylistData
    
    var body: some View {
        HStack {
            makeIcon(image: image)
                .padding(10)
            
            VStack(alignment: .leading) {
                Text("\(playlist.name)")
                    .navigationTitleTextStyle
                    .padding(.top, 10)
                
                Divider()
                
                Text("\(playlist.description)")
                    .mainTextStyle
                    .multilineTextAlignment(.leading)
               Spacer()
            }
        }
        .background(Color.barBackgroundGrey)
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .cornerRadius(Constant.Size.cornerRadius)
        .padding(.top, 5)
        .onChange(of: playlist, perform: { playlist in
            image = playlist.loadCover()
            print("name: \(playlist.name)")
        })
        .onAppear { image = playlist.loadCover() }
        .onDisappear { image = nil }
    }
    
    func makeIcon(image: UIImage?) -> some View {
        getImage(image: image)
            .resizable()
            .clipShape(Circle())
            .frame(width: 130, height: 130)
            .shadow(color: Color.white, radius: 1, x: 0.5, y: 0.5)
            .shadow(color: Color.white, radius: 1, x: -0.5, y: -0.5)
    }
    
    func getImage(image: UIImage?) -> Image {
        if let image = image {
            return  Image(uiImage: image)
        } else {
            return  Image("CirclePhoto")
        }
    }
}

struct PlaylistIconView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistIconView(playlist: PlaylistData(name: "Test name", description: "Test description", videoArr: []))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
