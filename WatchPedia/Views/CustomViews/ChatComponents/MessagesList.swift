//
//  MessagesList.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 7.12.2024.
//


import SwiftUI
import FirebaseAuth

struct MessagesList: View {
    let messages: [ChatMessage]
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack(spacing: 12) {
                    ForEach(messages) { message in
                        MessageBubble(
                            message: message,
                            isCurrentUser: message.senderId == Auth.auth().currentUser?.uid
                        )
                        .id(message.id)
                    }
                }
//                .onChange(of: messages) { _ in
//                    if let lastMessage = messages.last {
//                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
//                    }
//                }
            }
        }
    }
}
