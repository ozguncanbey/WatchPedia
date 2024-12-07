import SwiftUI

struct WatchlistScreen: View {
    @StateObject private var viewModel = WatchlistViewModel()
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            if viewModel.watchlistedContents.isEmpty {
                ContentUnavailableView("Your watchlist is empty", systemImage: "plus.circle", description: Text("Add content to see"))
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.watchlistedContents) { content in
                            NavigationLink(destination: DetailScreen(content: content)) {
                                PosterView(content: content)
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                .navigationTitle("Watchlist")
            }
        }
        .onAppear {
            viewModel.getWatchlistedContents()
        }
        .refreshable {
            viewModel.getWatchlistedContents()
        }
    }
}

#Preview {
    WatchlistScreen()
        .preferredColorScheme(.dark)
}
