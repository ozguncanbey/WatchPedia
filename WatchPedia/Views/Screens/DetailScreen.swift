//
//  DetailScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import SwiftUI

struct DetailScreen: View {
    @StateObject private var viewModel: DetailViewModel
    private let userDefault = UserDefaultsManager.shared
    @State private var isInWatchlist: Bool
    let content: ContentResult
    
    init(content: ContentResult) {
        self.content = content
        _viewModel = StateObject(wrappedValue: DetailViewModel(contentId: content.id ?? 0, isMovie: content.isMovie))
        isInWatchlist = userDefault.isInWatchlist(content)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack(alignment: .top, spacing: 15) {
                        PosterView(content: content)
                            .shadow(radius: 5)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text(viewModel.contentDetail?.displayTitle ?? "")
                                .font(.title2)
                                .fontWeight(.bold)
                                .lineLimit(2)
                            
                            HStack(spacing: 15) {
                                if let rating = viewModel.contentDetail?.rating {
                                    Label(rating, systemImage: "star.fill")
                                }
                                
                                Label(viewModel.contentDetail?.runtimeString ?? "",
                                      systemImage: "clock")
                            }
                            .font(.subheadline)
                            
                            Label(viewModel.contentDetail?.displayDate ?? "",
                                  systemImage: "calendar")
                            .font(.subheadline)
                            
                            if !content.isMovie {
                                Label(viewModel.contentDetail?.season ?? "",
                                      systemImage: "tv")
                                .font(.subheadline)
                            }
                            
                            Text(viewModel.contentDetail?.genresString ?? "")
                                .font(.caption)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                    .padding()
                    
                    // Overview
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Overview")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text(viewModel.contentDetail?.overview ?? "")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                    
                    if let videos = viewModel.contentVideoResult, !videos.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Videos")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(videos, id: \.key) { video in
                                        if video.type?.lowercased() == "trailer" {
                                            VStack(alignment: .leading) {
                                                TrailerView(videoKey: video.key ?? "")
                                                    .frame(width: 280)
                                                
                                                Text("Trailer")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                    }
                    
                    if let contentCast = viewModel.contentCast {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Cast")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            CastSection(castList: contentCast)
                        }
                    }
                    
                    if let similarContents = viewModel.similarContents {
                        Text(content.isMovie ? "Similar Movies" : "Similar Shows")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        ContentSection(title: "", contents: similarContents)
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle(content.isMovie ? content.title ?? "No Title" : content.name ?? "No Name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isInWatchlist ? userDefault.removeWatchlist(content) :  userDefault.addWatchlist(content)
                        
                        isInWatchlist.toggle()
                    } label: {
                        Image(systemName: isInWatchlist ? "film.circle.fill" : "film.circle")
                            .foregroundColor(isInWatchlist ? .blue : .primary)
                    }
                }
            }
        }
    }
}

extension ContentDetail {
    var displayTitle: String {
        title ?? name ?? "No Title"
    }
    
    var displayDate: String {
        if releaseDate != nil {
            return releaseDateString
        } else {
            return startEndDate
        }
    }
}

#Preview {
    DetailScreen(content: .dummy)
        .preferredColorScheme(.dark)
}
