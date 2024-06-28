//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingDetail = false
    @State private var selectedTab: Tabs = .downloadTab
    @State private var showDownloadPopUpView = false
    @State private var showDownloadFromPlaylistPopUpView = false
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color.barBackgroundGrey)
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().backgroundColor = UIColor(Color.barBackgroundGrey)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.lightGray)
    }
    
    enum Tabs: String {
        case downloadTab
        case playlistsTab
        case publicationsTab
        case settingsTab
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                DownloadTabView(showDownloadPopUpView: $showDownloadPopUpView)
                    .tabItem { makeTabItem(image: "arrow.down.doc", text: "Download") }
                    .tag(Tabs.downloadTab)
                
                PlaylistsTabView(showDownloadFromPlaylistPopUpView: $showDownloadFromPlaylistPopUpView)
                    .tabItem { makeTabItem(image: "star", text: "Playlists") }
                    .tag(Tabs.playlistsTab)
                
                PublicationsTabView()
                    .tabItem { makeTabItem(image: "clock.arrow.circlepath", text: "Publications") }
                    .tag(Tabs.publicationsTab)
                
                SettingsTabView()
                    .tabItem { makeTabItem(image: "gear", text: "Settings") }
                    .tag(Tabs.settingsTab)
            }
            .accentColor(.roseColor)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showingDetail){ InfoPopupView(viewData: PopupViewModel.intro)}
        .preferredColorScheme(.dark)
        .onAppear() {
            if !isAppAlreadyLaunchedOnce() {
                showingDetail = true
            }
        }
    }
    
    func makeTabItem(image: String, text: String) -> some View {
        Group {
            Image(systemName: image)
            Text(text)
        }
    }
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already launched : \(String(describing: isAppAlreadyLaunchedOnce))")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
