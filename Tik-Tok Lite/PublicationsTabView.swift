//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct PublicationsTabView : View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                VStack {
                    Spacer()
                    Image("Publications")
                        .scaleEffect(2, anchor: .center)
                        .padding(.bottom, 100)
                    
                    Text("Make your first delayed publication")
                        .mainTextStyle
                        .padding(.bottom, 200)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image("Calendar") .foregroundColor(.roseColor))
            .navigationTitle("Delayed publications")
            .font(.system(size: 16, weight: .regular, design: .default))
        }
    }
}

struct PublicationsTabView_Previews: PreviewProvider {
    static var previews: some View {
        PublicationsTabView()
    }
}
