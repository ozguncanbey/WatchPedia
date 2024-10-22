//
//  PosterView.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 18.10.2024.
//

import SwiftUI

struct PosterView: View {
    let content: ContentResult
    @State private var posterImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = posterImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: .dWidth / 2.5, height: .dHeight / 3.75)
                    .cornerRadius(16)
                    .padding(.trailing)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .frame(width: .dWidth / 2.5, height: .dHeight / 3.75)
                    .cornerRadius(16)
                    .padding(.trailing)
            }
        }
        .onAppear {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: API_URLs.imageURL(posterPath: content.posterPath ?? "")) else { return }
        
        NetworkManager.shared.download(url: url) { [self] result in
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async { self.posterImage = UIImage(data: data) }
            case .failure(_):
                break
            }
        }
    }
}
