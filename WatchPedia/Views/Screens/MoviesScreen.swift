//
//  MoviesScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 10.10.2024.
//

import SwiftUI

struct MoviesScreen: View {
    
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Popular")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
                
                HStack {
                    Text("Now Playing")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
                
                HStack {
                    Text("Upcoming")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
                
                HStack {
                    Text("Top Rated")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MoviesScreen()
        .preferredColorScheme(.dark)
}
