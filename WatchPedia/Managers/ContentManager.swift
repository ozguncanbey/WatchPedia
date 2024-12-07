//
//  ContentManager.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 7.12.2024.
//

import Foundation

final class ContentManager {
    static let shared = ContentManager()
    private let webService = WebService()
    
    private init() {}
    
    // Fetch movie details by ID
    func fetchMovieDetails(id: Int, completion: @escaping (ContentResult?) -> Void) {
        webService.downloadMovieDetail(id: id) { detail in
            guard let detail = detail else {
                completion(nil)
                return
            }
            
            let content = ContentResult(
                id: detail.id,
                overview: detail.overview,
                posterPath: detail.posterPath,
                releaseDate: detail.releaseDate,
                title: detail.title,
                name: nil,
                voteAverage: detail.voteAverage
            )
            completion(content)
        }
    }
    
    // Fetch show details by ID
    func fetchShowDetails(id: Int, completion: @escaping (ContentResult?) -> Void) {
        webService.downloadShowDetail(id: id) { detail in
            guard let detail = detail else {
                completion(nil)
                return
            }
            
            let content = ContentResult(
                id: detail.id,
                overview: detail.overview,
                posterPath: detail.posterPath,
                releaseDate: detail.releaseDate,
                title: nil,
                name: detail.name,
                voteAverage: detail.voteAverage
            )
            completion(content)
        }
    }
    
    // Fetch details for multiple IDs, determining if they are movies or shows
    func fetchMultipleContentDetails(ids: [Int], completion: @escaping ([ContentResult]) -> Void) {
        var contents: [ContentResult] = []
        let group = DispatchGroup()
        
        for id in ids {
            group.enter()
            
//            webService.downloadContentDetail(id: id) { detail in
//                guard let detail = detail else {
//                    group.leave()
//                    return
//                }
//                
//                if detail.isMovie {
//                    self.fetchMovieDetails(id: id) { content in
//                        if let content = content {
//                            contents.append(content)
//                        }
//                        group.leave()
//                    }
//                } else {
//                    self.fetchShowDetails(id: id) { content in
//                        if let content = content {
//                            contents.append(content)
//                        }
//                        group.leave()
//                    }
//                }
//            }
        }
        
        group.notify(queue: .main) {
            completion(contents)
        }
    }
}
