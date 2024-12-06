//
//  MainView.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var isCurrentUserExists = false
    
    var body: some View {
        if isCurrentUserExists {
            content
        } else {
            LoginScreen(isCurrentUserExists: $isCurrentUserExists)
        }
    }
    
    var content: some View {
        TabView {
            MoviesScreen()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            
            ShowsScreen()
                .tabItem {
                    Label("Shows", systemImage: "tv")
                }
            
            SearchScreen()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            WatchlistScreen()
                .tabItem {
                    Label("Watchlist", systemImage: "list.and.film")
                }
            
            SettingsScreen(isCurrentUserExists: $isCurrentUserExists)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .toolbar(.hidden, for: .automatic)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = .gray
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
