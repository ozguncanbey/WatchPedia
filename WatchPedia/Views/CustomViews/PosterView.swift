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
                    .fill(Color.gray.opacity(0.3))
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
        
        NetworkManager.shared.request(url, method: .GET) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.posterImage = image
                    }
                }
            case .failure(let error):
                print("Failed to download image: \(error.localizedDescription)")
            }
        }
    }
}
