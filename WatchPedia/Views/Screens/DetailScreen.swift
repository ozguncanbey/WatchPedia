//
//  DetailScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 11.10.2024.
//

import SwiftUI

struct DetailScreen: View {
    
    @StateObject private var viewModel = DetailViewModel()
    
    var body: some View {
        Text("Detail")
    }
}

#Preview {
    DetailScreen()
        .preferredColorScheme(.dark)
}
