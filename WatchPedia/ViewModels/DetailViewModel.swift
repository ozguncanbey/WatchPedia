//
//  DetailViewModel.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    private let service = WebService()
    
    @Published var contentDetail: ContentDetail? = nil
    
    init(contentId: Int, isMovie: Bool) {
        isMovie ? getMovieDetail(id: contentId) : getShowDetail(id: contentId)
    }
    
    func getMovieDetail(id: Int) {
        service.downloadMovieDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentDetail = result
            }
        }
    }
    
    func getShowDetail(id: Int) {
        service.downloadShowDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentDetail = result
            }
        }
    }
}
