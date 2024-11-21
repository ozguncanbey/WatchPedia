//
//  ContentDetail.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 22.10.2024.
//

import Foundation

// MARK: - ContentDetail
struct ContentDetail: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title, name: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video, name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

extension ContentDetail {
    static var dummy: ContentDetail {
        .init(adult: false, backdropPath: "", budget: 100, genres: [], homepage: "", id: 0, imdbID: "", originCountry: [], originalLanguage: "", originalTitle: "", overview: "Overview", popularity: 1, posterPath: "", releaseDate: "12/12/12", revenue: 0, runtime: 150, status: "", tagline: "", title: "Tite", name: "Name", video: true, voteAverage: 0, voteCount: 0)
    }
}
