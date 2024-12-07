//
//  MessageInputField.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 7.12.2024.
//


import SwiftUI

struct MessageInputField: View {
    @Binding var newMessage: String
    let onSend: () -> Void
    
    var body: some View {
        HStack {
            TextField("Type your message...", text: $newMessage)
                .textFieldStyle(.roundedBorder)
                .cornerRadius(50)
                .padding(8)
            
            Button(action: onSend) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.blue)
                    .padding()
                    .background(Circle().fill(Color.gray.opacity(0.2)))
            }
            .disabled(newMessage.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding()
    }
}
