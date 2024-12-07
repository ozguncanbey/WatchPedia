//
//  MessageBubble.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 7.12.2024.
//


import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("You")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(message.message)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
            } else {
                VStack(alignment: .leading) {
                    Text(message.username)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(message.message)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
