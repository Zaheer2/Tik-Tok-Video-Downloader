//
//  SplashScreen.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 06.04.2022.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var storageModel: StorageModel
    @EnvironmentObject var notifDelegate: NotificationDelegate
    
    @State private var splashAnimation: Bool = false
    
    var body: some View {
        ZStack {
            ContentView()
                .opacity(splashAnimation ? 1 : 0)
                .statusBar(hidden: true)
                .ignoresSafeArea()
            Group {
                AnimatedBackground().edgesIgnoringSafeArea(.all)
                Image("SplashLogoBig")
                    .iconModifier(width: Constant.Size.splashImageSize)
            }
            .opacity(splashAnimation ? 0 : 1)
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: false)
        .onAppear() {
            UNUserNotificationCenter.current().delegate =  notifDelegate
                withAnimation(.easeInOut(duration: 2)) {
                    splashAnimation.toggle()
                }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .environmentObject(NotificationDelegate())
    }
}

struct AnimatedBackground: View {
    @State private var start = UnitPoint(x: 0.2, y: 0.8)
    @State private var end = UnitPoint(x: 0, y: 1)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color.splashBackgroundMain, Color.splashBackgroundRose,]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .onReceive(timer, perform: { _ in
                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                    self.start = UnitPoint(x: 0.35, y: 0.65)
                }
            })
    }
}
