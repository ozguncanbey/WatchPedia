//
//  Content.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 14.10.2024.
//

import Foundation

struct Content: Codable {
    let page: Int?
    let results: [ContentResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ContentResult: Codable, Hashable, Identifiable {
    let id: Int?
    let overview: String?
    let posterPath, releaseDate, title, name: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, name
        case voteAverage = "vote_average"
    }
    
    var isMovie: Bool {
        title != nil && name == nil
    }
}

extension ContentResult {
    static var dummy: ContentResult {
        .init(id: 0, overview: "Overview", posterPath: "pp", releaseDate: "12/12/!2", title: "Title", name: "Name", voteAverage: 10)
    }
}
