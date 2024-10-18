//
//  ShowsScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct ShowsScreen: View {
    
    @StateObject private var viewModel = ShowsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ContentSection(title: "Popular", contents: viewModel.popularShows)
                    ContentSection(title: "Airing Today", contents: viewModel.airingTodayShows)
                    ContentSection(title: "On The Air", contents: viewModel.onTheAirShows)
                    ContentSection(title: "Top Rated", contents: viewModel.topRatedShows)
                }
            }
        }
        .onAppear {
            viewModel.getAllShows()
        }
    }
}

#Preview {
    ShowsScreen()
        .preferredColorScheme(.dark)
}
