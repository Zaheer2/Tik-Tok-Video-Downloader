//
//  PlaylistsEmptyTabView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 10.04.2022.
//

import SwiftUI

struct EmptyPlaylistsTabView: View {
    @Binding var index: Int?
    var body: some View {
        VStack {
            Spacer()
            
            Image("Play")
                .iconModifier(width: Constant.Size.promoImagesWidth)
            Text("Make your first playlist")
                .mainTextStyle
                .padding(.top, 50)
                .padding(.bottom, 100)
            
            NavigationLink(destination: PlaylistCreationView(index: index)) {
                makeMainButtonLabel(image: "star.fill",
                                    text: "Create playlist",
                                    isReversed: false,
                                    color: .rose)
            }
            .mainButtonStyle(color: .rose)
            .padding(.bottom, 50)
        }
    }
}

struct PlaylistsEmptyTabView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaylistsTabView(index: .constant(nil))
            .preferredColorScheme(.dark)
    }
}
