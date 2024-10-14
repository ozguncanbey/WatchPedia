//
//  MoviesViewModel.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import Foundation

final class MoviesViewModel: ObservableObject {
    
    private let service = WebService()
    
    @Published var popularMovies: [ContentResult] = []
    @Published var nowPlayingMovies: [ContentResult] = []
    @Published var upcomingMovies: [ContentResult] = []
    @Published var topRatedMovies: [ContentResult] = []
    
    init() { getAllMovies() }
    
    func getAllMovies() {
        service.downloadPopularMovies { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.popularMovies = result
            }
        }
        
        service.downloadNowPlayingMovies { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.nowPlayingMovies = result
            }
        }
        
        service.downloadUpcomingMovies { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.upcomingMovies = result
            }
        }
        
        
        service.downloadTopRatedMovies { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.topRatedMovies = result
            }
        }
    }
}
