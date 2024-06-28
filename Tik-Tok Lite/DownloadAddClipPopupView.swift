//
//  DownloadAddClipPopupView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 20.04.2022.
//

import SwiftUI

struct DownloadAddClipPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var storageModel: StorageModel
    
    @State private var downloadLink = ""
    @State private var offset: CGFloat = .zero
    
    @Binding var runLoading: Bool
    
    var playlistIndex: Int?
    
    var body: some View {
            VStack {
                HStack {
                    Text("Add clip")
                        .navigationTitleTextStyle
                    Spacer()
                    Button {
                        runLoading = false
                        closeView()
                    } label: { Image("CloseCircleGray") }
                }
                .padding(20)
                
                HStack {
                    Text("Link:")
                        .montserrat16TextStyle
                        .padding(.leading, 20)
                    Spacer()
                }
                
                TextField("Insert a link to the clip", text: $downloadLink)
                    .padding(10)
                    .frame(width: UIScreen.width * 0.92)
                    .background(Color.barGrey)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Button {
                    UIPasteboard.general.string = downloadLink
                    runLoading = true
                    closeView()
                } label: {
                    makeMainButtonLabel(image: "star.fill", text: "Add", isReversed: false, color: .rose)
                }
                .mainButtonStyle(color: .rose)
                .padding(.vertical, 10)
                Spacer()
            }
            .modifier( PopupOverlayViewModifier() {
                runLoading = false
                closeView()
            })
            .keyboardAwarePadding()
    }
    
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct DownloadAddClipPopupView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadAddClipPopupView(runLoading: .constant(true))
    }
}
