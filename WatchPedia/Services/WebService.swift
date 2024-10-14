//
//  WebService.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import Foundation

final class WebService {
    
    // MARK: - MOVIES
    
    func downloadPopularMovies(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.popularMovies(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func downloadNowPlayingMovies(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.nowPlayingMovies(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func downloadUpcomingMovies(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.upcomingMovies(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func downloadTopRatedMovies(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.topRatedMovies(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - SHOWS
    
    func downloadPopularShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.popularShows(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func downloadAiringTodayShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.airingTodayShows(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func downloadOnTheAirShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.onTheAirShows(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func downloadTopRatedShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.topRatedShows(page: 1)) else { return }
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                completion(content.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // When error occurs
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    // Decode the news from json and returns data as Article array
    private func handleWithData(_ data: Data) -> [ContentResult]? {
        do {
            let content = try JSONDecoder().decode(Content.self, from: data)
            return content.results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
