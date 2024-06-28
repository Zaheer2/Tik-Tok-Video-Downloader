//
//  DownloadAnimationPopupView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 19.04.2022.
//

import SwiftUI

struct DownloadAnimationPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageModel: StorageModel
    
    var playlistIndex: Int?
    
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
                .padding(.top, UIScreen.height * 0.09)
            Text("Clip is downloading")
            Spacer()
        }
        .modifier( PopupOverlayViewModifier() { closeView() } )
        .task {
            do {
                try await storageModel.tiktokTemp = Downloader.downloadTikTok(by: UIPasteboard.general.string!)
            } catch {
                Notification.noURLProvided()
                await MainActor.run { closeView() }
            }
            await MainActor.run {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                closeView() }
        }
        .onDisappear() {  saveTiktok() }
    }
    
    func saveTiktok() {
        if let playlistIndex = playlistIndex, let tiktok = storageModel.tiktokTemp {
            storageModel.add(video: tiktok, to: playlistIndex)
            storageModel.tiktokTemp = nil
        }
    }
    
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct DownloadAnimationPopupView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadAnimationPopupView()
    }
}
