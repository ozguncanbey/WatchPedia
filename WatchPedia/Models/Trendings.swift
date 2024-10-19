//
//  Trendings.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 19.10.2024.
//

import Foundation

struct Trendings: Codable {
    let page: Int?
    let results: [TrendingsResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TrendingsResult: Codable, Identifiable {
    let id: Int?
    let name, originalName: String?
    let mediaType: ResultMediaType?
    let adult: Bool?
    let popularity: Double?
    let gender: Int?
    let knownForDepartment: KnownForDepartment?
    let profilePath: String?
    let knownFor: [KnownFor]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case originalName = "original_name"
        case mediaType = "media_type"
        case adult, popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

struct KnownFor: Codable {
    let backdropPath: String?
    let id: Int?
    let title, originalTitle, overview, posterPath: String?
    let mediaType: KnownForMediaType?
    let adult: Bool?
    let originalLanguage: OriginalLanguage?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

enum KnownForMediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case ko = "ko"
    case pt = "pt"
    case tl = "tl"
    case zh = "zh"
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case directing = "Directing"
    case production = "Production"
}

enum ResultMediaType: String, Codable {
    case person = "person"
}

