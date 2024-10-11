//
//  MoviesScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct MoviesScreen: View {
    
    @StateObject var viewModel = MoviesViewModel()
    
    var body: some View {
        Text("Movies")
    }
}

#Preview {
    MoviesScreen()
        .preferredColorScheme(.dark)
}
