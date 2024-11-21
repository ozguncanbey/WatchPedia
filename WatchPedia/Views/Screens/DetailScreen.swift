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
        _viewModel = StateObject(wrappedValue: DetailViewModel(contentId: content.id ?? 0,
                                                               isMovie: content.isMovie))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    PosterView(content: content)
                        .padding()
                    
                    Spacer()
                    
                    VStack {
                        Text(content.title ?? "No Title")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Label(content.releaseDate ?? "", systemImage: "calendar")
                            .fontWeight(.light)
                        
//                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationTitle(content.title ?? "No title")
    }
}

#Preview {
    DetailScreen(content: .dummy)
        .preferredColorScheme(.dark)
}
