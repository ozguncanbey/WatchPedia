//
//  WatchlistViewModel.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import Foundation

final class WatchlistViewModel: ObservableObject {
    
    @Published var watchlistedContents: [ContentResult]? = []
    private let userDefault = UserDefaultsManager.shared
    
    func getWatchlistedContents() {
        watchlistedContents = userDefault.getWatchlisteds()
    }
}
