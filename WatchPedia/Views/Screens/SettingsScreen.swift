//
//  SettingsScreen.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 5.12.2024.
//

import SwiftUI
import FirebaseAuth

struct SettingsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isLoggedOut = false
    
    var body: some View {
        NavigationStack {
            Button("Log Out") {
                do {
                    try Auth.auth().signOut()
                    isLoggedOut = true
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            if isLoggedOut {
                NavigationLink(value: isLoggedOut) {
                    LoginScreen()
                }
                .onAppear {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    SettingsScreen()
        .preferredColorScheme(.dark)
}
