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
                    
                    VStack {
                        Text(content.isMovie ? viewModel.contentDetail?.title ?? "No Title" : viewModel.contentDetail?.name ?? "No Name")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Label((content.isMovie ? viewModel.contentDetail?.releaseDateString : viewModel.contentDetail?.startEndDate) ?? "", systemImage: "calendar")
                            .fontWeight(.light)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationTitle(content.isMovie ? viewModel.contentDetail?.title ?? "No Title" : viewModel.contentDetail?.name ?? "No Name")
        .navigationBarItems(trailing:
        Button(action: {
            
        }) { Image(systemName: "film.circle") }
        )
    }
}

#Preview {
    DetailScreen(content: .dummy)
        .preferredColorScheme(.dark)
}
