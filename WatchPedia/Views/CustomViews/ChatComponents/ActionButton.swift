//
//  ActionButton.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 13.12.2024.
//

import SwiftUI

struct ActionButton: View {
    let text: String
    let iconName: String
    let role: ButtonRole?
    let action: () -> Void
    
    var body: some View {
        Button(role: role) {
            action()
        } label: {
            HStack {
                Text(text)
                Image(systemName: iconName)
            }
            .padding()
            .background(Color.red.opacity(0.2))
            .cornerRadius(8)
        }
        .foregroundColor(.red)
    }
}
