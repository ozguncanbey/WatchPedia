//
//  ContentManager.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 7.12.2024.
//

import Foundation

enum ContentType {
    case movie
    case tv
}

final class ContentManager {
    static let shared = ContentManager()
    private let webService = WebService()
    
    private init() {}
    
    func fetchContentDetails(id: Int, contentType: ContentType, completion: @escaping (ContentResult?) -> Void) {
        switch contentType {
        case .movie:
            webService.downloadMovieDetail(id: id) { detail in
                // ContentDetail'ı ContentResult'a dönüştür
                if let detail = detail {
                    let content = ContentResult(
                        id: detail.id,
                        overview: detail.overview ?? "",
                        posterPath: detail.posterPath ?? "",
                        releaseDate: detail.releaseDate ?? "",
                        title: detail.title ?? "",
                        name: detail.name ?? "",
                        voteAverage: detail.voteAverage ?? 0.0
                    )
                    completion(content)
                } else {
                    completion(nil)
                }
            }
        case .tv:
            webService.downloadShowDetail(id: id) { detail in
                // ContentDetail'ı ContentResult'a dönüştür
                if let detail = detail {
                    let content = ContentResult(
                        id: detail.id,
                        overview: detail.overview ?? "",
                        posterPath: detail.posterPath ?? "",
                        releaseDate: detail.releaseDate ?? "",
                        title: detail.title ?? "",
                        name: detail.name ?? "",
                        voteAverage: detail.voteAverage ?? 0.0
                    )
                    completion(content)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func fetchMultipleContentDetails(ids: [Int], contentType: ContentType, completion: @escaping ([ContentResult]) -> Void) {
        var contents: [ContentResult] = []
        let group = DispatchGroup()
        
        for id in ids {
            group.enter()
            fetchContentDetails(id: id, contentType: contentType) { content in
                if let content = content {
                    contents.append(content)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(contents)
        }
    }
}
