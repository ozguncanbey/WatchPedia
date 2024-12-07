//
//  WatchlistViewModel.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import Foundation

final class WatchlistViewModel: ObservableObject {
    @Published var watchlistedContents: [ContentResult] = []
    
    private let watchlistManager = WatchlistManager.shared
    private let contentManager = ContentManager.shared
    
    func getWatchlistedContents() {
        watchlistManager.getWatchlist { [weak self] contentIds in
            guard let self = self else { return }
            
            // contentIds ile içerikleri al
            contentManager.fetchMultipleContentDetails(ids: contentIds) { contents in
                DispatchQueue.main.async {
                    self.watchlistedContents = contents
                }
            }
        }
    }
    
    func addContentToWatchlist(contentId: Int) {
        watchlistManager.addToWatchlist(contentId: contentId)
        getWatchlistedContents()
    }
    
    func removeContentFromWatchlist(contentId: Int) {
        watchlistManager.removeFromWatchlist(contentId: contentId)
        getWatchlistedContents()
    }
    
    func isContentInWatchlist(contentId: Int, completion: @escaping (Bool) -> Void) {
        watchlistManager.isInWatchlist(contentId: contentId, completion: completion)
    }
}
