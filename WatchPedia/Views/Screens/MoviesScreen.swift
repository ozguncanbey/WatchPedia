//
//  MoviesScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct MoviesScreen: View {
    
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ContentSection(title: "Popular", contents: viewModel.popularMovies)
                    ContentSection(title: "Now Playing", contents: viewModel.nowPlayingMovies)
                    ContentSection(title: "Upcoming", contents: viewModel.upcomingMovies)
                    ContentSection(title: "Top Rated", contents: viewModel.topRatedMovies)
                }
            }
        }
        .onAppear {
            viewModel.getAllMovies()
        }
    }
}

#Preview {
    MoviesScreen()
        .preferredColorScheme(.dark)
}
