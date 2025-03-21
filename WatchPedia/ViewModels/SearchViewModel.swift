//
//  SearchViewModel.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import Foundation

final class SearchViewModel: ObservableObject {
    
    private let service = WebService()
    
    @Published var allTrendings: [ContentResult]? = []
    @Published var multiSearched: [ContentResult]? = []
    
    init() { getAllTrendings() }
    
    func getAllTrendings() {
        service.downloadAllTrendings { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.allTrendings = result
            }
        }
    }
    
    func getMultiSearched(query: String) {
        service.downloadMultiSearch(query: query) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.multiSearched = result
            }
        }
    }
}
