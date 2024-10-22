//
//  DetailScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import SwiftUI

struct DetailScreen: View {
    
    @StateObject private var viewModel = DetailViewModel()
    
    let content: ContentResult
    
    var body: some View {
        Text(content.title ?? "No Title")
    }
}

#Preview {
    DetailScreen(content: .dummy)
        .preferredColorScheme(.dark)
}
