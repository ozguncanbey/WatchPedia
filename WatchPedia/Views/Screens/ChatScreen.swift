//
//  ChatScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 6.12.2024.
//

import SwiftUI

struct ChatScreen: View {
    
    @State var contentTitle: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Chat")
            }
            .navigationTitle(contentTitle)
        }
    }
}

#Preview {
    ChatScreen(contentTitle: "Title")
        .preferredColorScheme(.dark)
}
