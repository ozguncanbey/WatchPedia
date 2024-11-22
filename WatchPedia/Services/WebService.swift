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
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadNowPlayingMovies(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.nowPlayingMovies(page: 1)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadUpcomingMovies(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.upcomingMovies(page: 1)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadTopRatedMovies(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.topRatedMovies(page: 1)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadMovieDetail(id: Int, completion: @escaping (ContentDetail?) -> ()) {
        guard let url = URL(string: API_URLs.movieDetail(id: id)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadMovieVideo(id: Int, completion: @escaping ([VideoResult]?) -> ()) {
        guard let url = URL(string: API_URLs.movieVideo(id: id)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    // MARK: - SHOWS
    
    func downloadPopularShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.popularShows(page: 1)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadAiringTodayShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.airingTodayShows(page: 1)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadOnTheAirShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.onTheAirShows(page: 1)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadTopRatedShows(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.topRatedShows(page: 1)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadShowDetail(id: Int, completion: @escaping (ContentDetail?) -> ()) {
        guard let url = URL(string: API_URLs.showDetail(id: id)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    func downloadShowVideo(id: Int, completion: @escaping ([VideoResult]?) -> ()) {
        guard let url = URL(string: API_URLs.showVideo(id: id)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
            }
        }
    }
    
    // MARK: - SEARCH
    
    func downloadAllTrendings(completion: @escaping ([ContentResult]?) -> ()) {
        guard let url = URL(string: API_URLs.allTrendings()) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(handleWithData(data))
            case .failure(let error):
                handleWithError(error)
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
    
    private func handleWithData(_ data: Data) -> ContentDetail? {
        do {
            let content = try JSONDecoder().decode(ContentDetail.self, from: data)
            return content
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func handleWithData(_ data: Data) -> [VideoResult]? {
        do {
            let video = try JSONDecoder().decode(Video.self, from: data)
            return video.results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
