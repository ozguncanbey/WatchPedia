//
//  ContentSection.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 18.10.2024.
//

import SwiftUI

func ContentSection(title: String, contents: [ContentResult]) -> some View {
    VStack(alignment: .leading) {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding(.leading)
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(contents) { content in
                    PosterView(content: .contentResult(content))
                }
            }
            .padding(.horizontal)
        }
    }
}
