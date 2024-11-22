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
    @Published var contentVideoResult: [VideoResult]? = []
    @Published var similarContents: [ContentResult]? = []
    @Published var contentCast: [Cast]? = []
    
    init(contentId: Int, isMovie: Bool) {
        if (isMovie) {
            getMovieDetail(id: contentId)
            getMovieVideo(id: contentId)
            getSimilarMovies(id: contentId)
            getMovieCast(id: contentId)
        } else {
            getShowDetail(id: contentId)
            getShowVideo(id: contentId)
            getSimilarShows(id: contentId)
            getShowCast(id: contentId)
        }
    }
    
    // MARK: - MOVIE
    
    func getMovieDetail(id: Int) {
        service.downloadMovieDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentDetail = result
            }
        }
    }
    
    func getMovieVideo(id: Int) {
        service.downloadMovieVideo(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentVideoResult = result
            }
        }
    }
    
    func getSimilarMovies(id: Int) {
        service.downloadSimilerMovies(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.similarContents = result
            }
        }
    }
    
    func getMovieCast(id: Int) {
        service.downloadMovieCast(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentCast = result
            }
        }
    }
    
    // MARK: - SHOW
    
    func getShowDetail(id: Int) {
        service.downloadShowDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentDetail = result
            }
        }
    }
    
    func getShowVideo(id: Int) {
        service.downloadShowVideo(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentVideoResult = result
            }
        }
    }
    
    func getSimilarShows(id: Int) {
        service.downloadSimilerShows(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.similarContents = result
            }
        }
    }
    
    func getShowCast(id: Int) {
        service.downloadShowCast(id: id) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            
            DispatchQueue.main.async {
                self.contentCast = result
            }
        }
    }
}
