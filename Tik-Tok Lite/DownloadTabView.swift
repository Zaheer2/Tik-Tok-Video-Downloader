//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI
import AVKit
import AVFoundation

struct DownloadTabView: View {
    @EnvironmentObject var storageModel: StorageModel
    
    @State private var showingPromoView = false
    @State private var showingInfoView = false
    @State private var showDownloadAndPlayView = false
    
    @Binding var showDownloadPopUpView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                VStack {
                    HStack {
                        Text("Instruction")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                        showingPromoViewButton
                    }
                    .padding(16)
                    
                    Spacer()
                    
                    Image("Download")
                        .scaleEffect(1.6, anchor: .center)
                    
                    Text("Download clip")
                        .mainTextStyle
                        .padding(.top, 50)
                        .padding(.bottom, 100)
                    
                    downloadClipButton
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: showingInfoViewButton)
                .navigationTitle("Download clip")
                .font(.system(size: 16, weight: .regular, design: .default))
            }
            .popover(isPresented: $showDownloadAndPlayView) {
                DownloadAndPlayPopupView(
                    player: AVPlayer(url: storageModel.tiktokTemp!.url(forFile: .video)))
                    .onDisappear { storageModel.tiktokTemp = nil }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: false)
    }
    
    //MARK: showingInfoViewButton
    
    var showingInfoViewButton: some View {
        Button(action: { showingInfoView = true }){
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(.roseColor)
        }
        .fullScreenCover(isPresented: $showingInfoView) {
            InfoPopupView(viewData: PopupViewModel.intro)
        }
    }
    
    //MARK: showingPromoViewButton
    
    var showingPromoViewButton: some View {
        Button(action: { showingPromoView = true }){
            ZStack{
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.roseColor, lineWidth: 1)
                    .frame(width: 181, height: 35)
                    .blur(radius: 1 )
                HStack{
                    Image("Discount")
                    Text("Month free")
                        .foregroundColor(Color.roseColor)
                }
            }
        }
        .fullScreenCover(isPresented: $showingPromoView) {
            InfoPopupView(viewData: PopupViewModel.promotion)
        }
    }
    
    //MARK: downloadClipButton
    
    var downloadClipButton: some View {
        Button(action: { showDownloadPopUpView = true }){
            makeMainButtonLabel(image: "arrow.down.doc.fill", text: "Download clip", isReversed: false, color: .rose)
        }
        .mainButtonStyle(color: .rose)
        .padding(.bottom, 50)
        .fullScreenCover(isPresented:  $showDownloadPopUpView, onDismiss: ({
            if storageModel.tiktokTemp != nil {
                showDownloadAndPlayView = true
            }
        })){
            DownloadAnimationPopupView()
        }
    }
}

struct DownloadTabView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadTabView(showDownloadPopUpView: .constant(false))
    }
}
