//
//  API_URLs.swift
//  HappyBirthDays
//
//  Created by Özgün Can Beydili on 28.06.2024.
//

import Foundation

enum API_URLs {
    
    static private let baseURL = "https://api.themoviedb.org/3/"
    static private let apikey = "77169f34443a11aad96f597bef1c2fb3"
    
    // MARK: - MOVIES
    
    static func popularMovies(page: Int) -> String {
        "\(baseURL)movie/popular?api_key=\(apikey)&language=en-US&page=\(page)"
    }
    
    static func nowPlayingMovies(page: Int) -> String {
        "\(baseURL)movie/now_playing?api_key=\(apikey)&language=en-US&page=\(page)"
    }
    
    static func upcomingMovies(page: Int) -> String {
        "\(baseURL)movie/upcoming?api_key=\(apikey)&language=en-US&page=\(page)"
    }
    
    static func topRatedMovies(page: Int) -> String {
        "\(baseURL)movie/top_rated?api_key=\(apikey)&language=en-US&page=\(page)"
    }
    
    // MARK: - SHOWS
    
    static func popularShows(page: Int) -> String {
        "\(baseURL)tv/popular?api_key=\(apikey)&language=en-US&page=\(page)"
    }
    
    static func airingTodayShows(page: Int) -> String {
        "\(baseURL)tv/airing_today?api_key=\(apikey)&language=en-US&page=\(page)"
    }
    
    static func onTheAirShows(page: Int) -> String {
        "\(baseURL)tv/on_the_air?api_key=\(apikey)&language=en-US&page=\(page)"
    }
    
    static func topRatedShows(page: Int) -> String {
        "\(baseURL)tv/popular?api_key=\(apikey)&language=en-US&page=\(page)"
    }
}
