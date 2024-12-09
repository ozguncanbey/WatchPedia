import Foundation

final class WatchlistViewModel: ObservableObject {
    @Published var watchlistedContents: [ContentResult] = []
    
    private let watchlistManager = WatchlistManager.shared
    private let contentManager = ContentManager.shared
    
    func getWatchlistedContents() {
        var fetchedContents: [ContentResult] = []
        let group = DispatchGroup()
        
        // Fetch movies
        group.enter()
        watchlistManager.getMovieWatchlist { movieIds in
            for movieId in movieIds {
                group.enter()
                self.contentManager.fetchMovieDetails(id: movieId) { movieDetail in
                    if let movieDetail = movieDetail {
                        fetchedContents.append(movieDetail)
                    }
                    group.leave()
                }
            }
            group.leave()
        }
        
        // Fetch shows
        group.enter()
        watchlistManager.getShowWatchlist { showIds in
            for showId in showIds {
                group.enter()
                self.contentManager.fetchShowDetails(id: showId) { showDetail in
                    if let showDetail = showDetail {
                        fetchedContents.append(showDetail)
                    }
                    group.leave()
                }
            }
            group.leave()
        }
        
        // Notify when all tasks are completed
        group.notify(queue: .main) {
            self.watchlistedContents = fetchedContents
        }
    }
}
