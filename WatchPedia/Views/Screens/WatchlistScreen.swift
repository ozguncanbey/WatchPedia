//
//  WatchlistScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct WatchlistScreen: View {
    
    @StateObject private var viewModel = WatchlistViewModel()
    private let userDefault = UserDefaultsManager.shared
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            if userDefault.getWatchlisteds().isEmpty {
                ContentUnavailableView("Your watchlist is empty", systemImage: "plus.circle", description: Text("Add content to see"))
                //            .offset(y: -60)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        if let watchlisted = viewModel.watchlistedContents {
                            ForEach(watchlisted) { content in
                                NavigationLink(destination: DetailScreen(content: content)) {
                                    PosterView(content: content)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                .navigationTitle("Watchlist")
            }
        }
        .onAppear {
            viewModel.getWatchlistedContents()
        }
    }
}

#Preview {
    WatchlistScreen()
        .preferredColorScheme(.dark)
}
