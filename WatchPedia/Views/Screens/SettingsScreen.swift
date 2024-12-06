//
//  SettingsScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 5.12.2024.
//

import SwiftUI
import FirebaseAuth

struct SettingsScreen: View {
    
    @Binding var isCurrentUserExists: Bool
    
    var body: some View {
        NavigationStack {
            Button("Log Out") {
                do {
                    try Auth.auth().signOut()
                    isCurrentUserExists = false
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    SettingsScreen(isCurrentUserExists: .constant(false))
        .preferredColorScheme(.dark)
}
