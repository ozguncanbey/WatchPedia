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
        guard let posterPath = content.posterPath,
              let url = URL(string: API_URLs.imageURL(posterPath: posterPath)) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response status code")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            DispatchQueue.main.async {
                self.posterImage = image
            }
        }.resume()
    }
}
