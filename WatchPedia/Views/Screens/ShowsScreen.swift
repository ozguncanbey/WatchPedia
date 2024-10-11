//
//  ShowsScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct ShowsScreen: View {
    
    @StateObject var viewModel = ShowsViewModel()
    
    var body: some View {
        Text("Shows")
    }
}

#Preview {
    ShowsScreen()
        .preferredColorScheme(.dark)
}
