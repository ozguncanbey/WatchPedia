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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Explore")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
            }
        }
        .searchable(text: $searchTerm, prompt: "Search movie or show")
    }
}

#Preview {
    SearchScreen()
        .preferredColorScheme(.dark)
}
