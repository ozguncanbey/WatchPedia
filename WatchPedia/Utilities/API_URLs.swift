//
//  API_URLs.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import Foundation

enum API_URLs {
    
    static private let baseURL = "https://api.themoviedb.org/3/"
    static private let api_key = "77169f34443a11aad96f597bef1c2fb3"
    
    // MARK: - MOVIES
    
    static func popularMovies(page: Int) -> String {
        "\(baseURL)movie/popular?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func nowPlayingMovies(page: Int) -> String {
        "\(baseURL)movie/now_playing?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func upcomingMovies(page: Int) -> String {
        "\(baseURL)movie/upcoming?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func topRatedMovies(page: Int) -> String {
        "\(baseURL)movie/top_rated?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func movieDetail(id: Int) -> String {
        "\(baseURL)movie/\(id)?api_key=\(api_key)"
    }
    
    static func movieVideo(id: Int) -> String {
        return "\(baseURL)movie/\(id)/videos?api_key=\(api_key)&language=en-US"
    }
        
    static func similarMovies(id: Int, page: Int) -> String {
        "\(baseURL)movie/\(id)/similar?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func movieCast(id: Int) -> String {
        return "\(baseURL)movie/\(id)/credits?api_key=\(api_key)"
    }
    
    // MARK: - SHOWS
    
    static func popularShows(page: Int) -> String {
        "\(baseURL)tv/popular?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func airingTodayShows(page: Int) -> String {
        "\(baseURL)tv/airing_today?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func onTheAirShows(page: Int) -> String {
        "\(baseURL)tv/on_the_air?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func topRatedShows(page: Int) -> String {
        "\(baseURL)tv/top_rated?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func showDetail(id: Int) -> String {
        "\(baseURL)tv/\(id)?api_key=\(api_key)"
    }
    
    static func showVideo(id: Int) -> String {
        return "\(baseURL)tv/\(id)/videos?api_key=\(api_key)&language=en-US"
    }
    
    static func similarShows(id: Int, page: Int) -> String {
        "\(baseURL)tv/\(id)/similar?api_key=\(api_key)&language=en-US&page=\(page)"
    }
    
    static func showCast(id: Int) -> String {
        return "\(baseURL)tv/\(id)/credits?api_key=\(api_key)"
    }
    
    // MARK: - SEARCH
    
    static func allTrendings() -> String {
        "\(baseURL)trending/all/day?api_key=\(api_key)"
    }
    
    static func multiSearch(query: String, page: Int) -> String {
        return "\(baseURL)search/multi?api_key=\(api_key)&language=en-US&query=\(query)&page=\(page)&include_adult=false"
    }
    
    // MARK: - IMAGE
    
    static func imageURL(posterPath: String) -> String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
}
