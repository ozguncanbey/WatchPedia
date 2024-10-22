//
//  SearchScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct SearchScreen: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchTerm = ""
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Explore")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.allTrendings) { content in
                            NavigationLink(destination: DetailScreen(content: content)) {
                                PosterView(content: content)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .searchable(text: $searchTerm, prompt: "Search movie or show")
        }
    }
}

#Preview {
    SearchScreen()
        .preferredColorScheme(.dark)
}
