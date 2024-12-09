import Foundation
import FirebaseAuth
import FirebaseFirestore

final class WatchlistManager {
    
    static let shared = WatchlistManager()
    private init() {}
    
    private let db = Firestore.firestore()
    private var userId: String {
        Auth.auth().currentUser?.uid ?? "defaultUserId"
    }
    
    // Add content to the appropriate watchlist (movies or shows)
    func addToWatchlist(contentId: Int, isMovie: Bool) {
        let collectionName = isMovie ? "movies" : "shows"
        let watchlistRef = db.collection("users").document(userId).collection("watchlist").document(collectionName)
        
        watchlistRef.collection("contents").document("\(contentId)").setData([
            "contentId": contentId
        ]) { error in
            if let error = error {
                print("Error adding to \(collectionName) watchlist: \(error.localizedDescription)")
            }
        }
    }
    
    // Remove content from the appropriate watchlist (movies or shows)
    func removeFromWatchlist(contentId: Int, isMovie: Bool) {
        let collectionName = isMovie ? "movies" : "shows"
        let watchlistRef = db.collection("users").document(userId).collection("watchlist").document(collectionName)
        
        watchlistRef.collection("contents").document("\(contentId)").delete { error in
            if let error = error {
                print("Error removing from \(collectionName) watchlist: \(error.localizedDescription)")
            }
        }
    }
    
    // Check if content is in the appropriate watchlist (movies or shows)
    func isInWatchlist(contentId: Int, isMovie: Bool, completion: @escaping (Bool) -> Void) {
        let collectionName = isMovie ? "movies" : "shows"
        let watchlistRef = db.collection("users").document(userId).collection("watchlist").document(collectionName)
        
        watchlistRef.collection("contents").document("\(contentId)").getDocument { document, error in
            if let error = error {
                print("Error checking \(collectionName) watchlist: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(document?.exists ?? false)
            }
        }
    }
    
    func getMovieWatchlist(completion: @escaping ([Int]) -> Void) {
        let moviesRef = db.collection("users").document(userId).collection("watchlist").document("movies").collection("contents")
        
        moviesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching movies watchlist: \(error.localizedDescription)")
                completion([])
            } else {
                let movieIds = snapshot?.documents.compactMap { $0.data()["contentId"] as? Int } ?? []
                completion(movieIds)
            }
        }
    }
    
    func getShowWatchlist(completion: @escaping ([Int]) -> Void) {
        let showsRef = db.collection("users").document(userId).collection("watchlist").document("shows").collection("contents")
        
        showsRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching shows watchlist: \(error.localizedDescription)")
                completion([])
            } else {
                let showIds = snapshot?.documents.compactMap { $0.data()["contentId"] as? Int } ?? []
                completion(showIds)
            }
        }
    }
}
