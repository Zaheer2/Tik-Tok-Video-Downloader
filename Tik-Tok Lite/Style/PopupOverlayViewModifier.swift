//
//  PopupView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 19.04.2022.
//

import SwiftUI

struct PopupOverlayViewModifier: ViewModifier {
    @State private var backOpacity: Double = .leastNonzeroMagnitude
    
    var action: () -> Void = {}
    
    func body(content: Content) -> some View {
            ZStack {
                Color.black.opacity(backOpacity)
                    .onAppear {
                        withAnimation(.linear(duration: 0.6).delay(0.3)) { backOpacity = 0.5 }
                    }
                    .onTapGesture {
                        backOpacity = .zero
                        action()
                    }
                VStack {
                    Spacer()
                content
                    .frame(width: UIScreen.width, height: Constant.Size.popupViewHeight)
                    .background(Color.barBackgroundGrey)
                    .clipShape(RoundedRectangle(cornerRadius: Constant.Size.popupViewCornerRadius))
                }
            }
            .ignoresSafeArea()
            .background(BackgroundCleanerView())
    }
}
