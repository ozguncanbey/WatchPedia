//
//  WatchlistScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct WatchlistScreen: View {
    
    @StateObject private var viewModel = WatchlistViewModel()
    
    var body: some View {
        ContentUnavailableView("Your watchlist is empty", systemImage: "plus.circle", description: Text("Add content to see"))
//            .offset(y: -60)
    }
}

#Preview {
    WatchlistScreen()
        .preferredColorScheme(.dark)
}
