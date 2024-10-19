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
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

extension ContentResult {
    static var dummy: ContentResult {
        .init(id: 0, overview: "Overview", posterPath: "", releaseDate: "12/12/!2", title: "Title", voteAverage: 10)
    }
}
