//
//  VideoIconView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.04.2022.
//

import SwiftUI

struct VideoIconView: View {
    @State var image: UIImage? = nil
    @Binding var tiktok: Tiktok
    
    
    var body: some View {
        ZStack {
            Color.barBackgroundGrey
            
            HStack{
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 109, height: 148)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 7)
                    
                } else {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.barBackgroundGrey)
                            .frame(width: 109, height: 148)
                            .shadow(color: Color.white, radius: 2)
                        Image("CirclePhoto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                }
                
                VStack(alignment: .leading) {
                    if let name = tiktok.data?.desc {
                        Text("\(name)")
                            .font(Font.custom("Montserrat", size: 12.0))
                            .padding(.top, 10)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding(.horizontal, 10)
        .padding(.top, 5)
        .onChange(of: tiktok.fileName, perform: { newValue in
            image = tiktok.loadCover()
            print("name: \(tiktok.fileName)")
        })
        .onAppear {
            image = tiktok.loadCover()
        }
        .onDisappear {
           image = nil
        }
    }
}

//struct VideoIconView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoIconView(tiktok: Tiktok(withFileName: "123", withData: nil))
//    }
//}
