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
    let onDeleteMessage: (ChatMessage) -> Void
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack(spacing: 12) {
                    ForEach(messages) { message in
                        MessageBubble(
                            message: message,
                            isCurrentUser: message.senderId == Auth.auth().currentUser?.uid,
                            onDeleteMessage: onDeleteMessage
                        )
                        .id(message.id)
                    }
                }
                .onChange(of: messages) {
                    if let lastMessage = messages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
        }
    }
}
