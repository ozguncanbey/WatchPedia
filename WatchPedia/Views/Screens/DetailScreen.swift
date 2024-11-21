//
//  DetailScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import SwiftUI

struct DetailScreen: View {
    
    @StateObject private var viewModel: DetailViewModel
    let content: ContentResult
    
    init(content: ContentResult) {
        self.content = content
        _viewModel = StateObject(wrappedValue: DetailViewModel(contentId: content.id ?? 0, isMovie: content.isMovie))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    PosterView(content: content)
                        .padding()
                    
                    Spacer()
                    
                    VStack {
                        Text(content.isMovie ? viewModel.contentDetail?.title ?? "No Title" : viewModel.contentDetail?.name ?? "No Name")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Label(viewModel.contentDetail?.releaseDate ?? "", systemImage: "calendar")
                            .fontWeight(.light)
                        
//                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationTitle(content.isMovie ? viewModel.contentDetail?.title ?? "No Title" : viewModel.contentDetail?.name ?? "No Name")
    }
}

#Preview {
    DetailScreen(content: .dummy)
        .preferredColorScheme(.dark)
}
