//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct InfoPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTab = 0
    
    var viewData: [PopupViewModel]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                ZStack() {
                    Text(viewData[0].headText)
                        .fontWeight(.black)
                        .foregroundColor(.roseColor)
                    
                    HStack {
                        Spacer()
                        Button(action: { closeTabView() }) {
                            Image("CloseX")
                                .frame(width: 30, height: 30).background(Color.black)
                                .padding(.trailing, 28)
                        }
                    }
                }
                .padding(.top, 10)
                
                TabView(selection: $selectedTab) {
                    ForEach(viewData.indices, id: \.self) { index in
                        ZStack{
                            VStack{
                                Spacer()
                                VStack{
                                    Image(viewData[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: Constant.Size.promoImagesWidth)
                                }
                                Spacer()
                                
                                Text(viewData[index].numberText)
                                    .font(.system(size: 21, weight: .regular, design: .default))
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 5)
                                
                                Text(viewData[index].instructionText).mainTextStyle
                                    .padding(.bottom, 20)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .overlay(ThreeDotsIndexView(numberOfPages: viewData.count, selectedTab: selectedTab), alignment: .bottom )
                .padding(.bottom, 45)
                
                Button(action: {
                    if selectedTab != 2 {
                        selectedTab += 1
                        return
                    }
                    closeTabView()
                }) {
                    makeMainButtonLabel(image: "arrow.right.square.fill", text: "Next", isReversed: true, color: .rose)
                }
                .mainButtonStyle(color: .rose)
                .padding(.bottom, 50)
            }
        }
    }
        func closeTabView() {  presentationMode.wrappedValue.dismiss() }
}

struct InfoPopupView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPopupView(viewData: PopupViewModel.intro)
    }
}

