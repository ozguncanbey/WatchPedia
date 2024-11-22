//
//  UserDefaultsManager.swift
//  
//
//  Created by Özgün Can Beydili on 9.05.2024.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let forKey = "UserDefaultsKey"
    
    func addWatchlist(_ content: ContentResult) {
        var watchlist = getWatchlisteds()
        watchlist.append(content)
        saveWatchlisteds(watchlist)
    }
    
    func removeWatchlist(_ content: ContentResult) {
        var watchlist = getWatchlisteds()
        if let index = watchlist.firstIndex(where: { $0.id == content.id }) {
            watchlist.remove(at: index)
            saveWatchlisteds(watchlist)
        }
    }
    
    func isInWatchlist(_ content: ContentResult) -> Bool {
        let watchlisteds = getWatchlisteds()
        return watchlisteds.contains { $0.id == content.id }
    }
    
    func getWatchlisteds() -> [ContentResult] {
        if let data = userDefaults.data(forKey: forKey),
           let watchlisteds = try? JSONDecoder().decode([ContentResult].self, from: data) { return watchlisteds.reversed() }
        return []
    }
    
    private func saveWatchlisteds(_ watchlists: [ContentResult]) {
        if let data = try? JSONEncoder().encode(watchlists) {
            userDefaults.set(data, forKey: forKey)
        }
    }
}
