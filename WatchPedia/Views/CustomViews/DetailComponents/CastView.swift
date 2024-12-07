import SwiftUI

struct CastView: View {
    
    let cast: Cast
    @State private var profileImage: UIImage?
    
    private var imageUrl: URL? {
        guard let path = cast.profilePath else { return nil }
        return URL(string: API_URLs.imageURL(posterPath: path))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Cast Image
            VStack(alignment: .leading) {
                if let image = profileImage {
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
            
            // Cast Info
            VStack(alignment: .leading, spacing: 4) {
                Text(cast.name ?? "")
                    .font(.callout)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                if let character = cast.character {
                    Text(character)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            .frame(width: 120)
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: API_URLs.imageURL(posterPath: cast.profilePath ?? "")) else { return }
        
        NetworkManager.shared.download(url: url) { [self] result in
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async { self.profileImage = UIImage(data: data) }
            case .failure(_):
                break
            }
        }
    }
}

struct CastSection: View {
    let castList: [Cast]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(castList, id: \.id) { cast in
                    CastView(cast: cast)
                }
            }
            .padding(.horizontal)
        }
    }
}
