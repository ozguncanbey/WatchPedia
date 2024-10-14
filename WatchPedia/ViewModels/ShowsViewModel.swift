//
//  ShowsViewModel.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import Foundation

final class ShowsViewModel: ObservableObject {
    
    private let service = WebService()
    
    @Published var popularShows: [ContentResult] = []
    @Published var airingTodayShows: [ContentResult] = []
    @Published var onTheAirShows: [ContentResult] = []
    @Published var topRatedShows: [ContentResult] = []
    
    init() { getAllShows() }
    
    func getAllShows() {
        service.downloadPopularShows { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.popularShows = result
            }
        }
        
        service.downloadAiringTodayShows{ [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.airingTodayShows = result
            }
        }
        
        service.downloadOnTheAirShows { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.onTheAirShows = result
            }
        }
        
        
        service.downloadTopRatedShows { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.topRatedShows = result
            }
        }
    }
}
