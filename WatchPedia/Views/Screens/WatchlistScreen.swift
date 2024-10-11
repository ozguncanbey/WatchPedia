//
//  WatchlistScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct WatchlistScreen: View {
    
    @StateObject var viewModel = WatchlistViewModel()
    
    var body: some View {
        Text("Watchlist")
    }
}

#Preview {
    WatchlistScreen()
        .preferredColorScheme(.dark)
}
