//
//  DetailScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import SwiftUI

struct DetailScreen: View {
    
    @StateObject private var viewModel = DetailViewModel()
    
    let content: AllResults
    
    var body: some View {
        Text("Detail")
    }
}

#Preview {
    DetailScreen(content: .contentResult(.dummy))
        .preferredColorScheme(.dark)
}
