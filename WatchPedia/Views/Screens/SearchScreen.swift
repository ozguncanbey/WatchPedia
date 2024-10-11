//
//  SearchScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct SearchScreen: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        Text("Search")
    }
}

#Preview {
    SearchScreen()
        .preferredColorScheme(.dark)
}
