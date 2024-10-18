//
//  MainView.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
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
        }
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = .gray
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
