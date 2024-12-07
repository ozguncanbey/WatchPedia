//
//  WatchlistManager.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 7.12.2024.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

final class WatchlistManager {
    
    static let shared = WatchlistManager()
    private init() {}
    
    private let db = Firestore.firestore()
    private let userId = Auth.auth().currentUser?.uid ?? "defaultUserId"
    
    func addToWatchlist(contentId: Int) {
            let watchlistRef = db.collection("users").document(userId).collection("watchlist")
            
            watchlistRef.document("\(contentId)").setData([
                "contentId": contentId
            ]) { error in
                if let error = error {
                    print("Error adding to watchlist: \(error.localizedDescription)")
                } else {
                    print("Content added to watchlist successfully")
                }
            }
        }
        
        func removeFromWatchlist(contentId: Int) {
            let watchlistRef = db.collection("users").document(userId).collection("watchlist")
            
            watchlistRef.document("\(contentId)").delete() { error in
                if let error = error {
                    print("Error removing from watchlist: \(error.localizedDescription)")
                } else {
                    print("Content removed from watchlist successfully")
                }
            }
        }
        
        func isInWatchlist(contentId: Int, completion: @escaping (Bool) -> Void) {
            let watchlistRef = db.collection("users").document(userId).collection("watchlist")
            
            watchlistRef.document("\(contentId)").getDocument { document, error in
                if let error = error {
                    print("Error checking watchlist: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(document?.exists ?? false)
                }
            }
        }
        
        func getWatchlist(completion: @escaping ([Int]) -> Void) {
            let watchlistRef = db.collection("users").document(userId).collection("watchlist")
            
            watchlistRef.getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching watchlist: \(error.localizedDescription)")
                    completion([])
                } else {
                    let contentIds = snapshot?.documents.compactMap { $0.data()["contentId"] as? Int } ?? []
                    completion(contentIds)
                }
            }
        }
}
