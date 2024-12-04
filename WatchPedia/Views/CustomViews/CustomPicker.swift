//
//  CustomPicker.swift
//  WatchPedia
//
//  Created by Özgün Can Beydili on 4.12.2024.
//

import SwiftUI

struct CustomPicker: View {
    @Binding var isAdminSelected: Bool

    var body: some View {
        HStack {
            Button(action: {
                isAdminSelected = false
            }) {
                Text("User")
                    .fontWeight(isAdminSelected ? .regular : .bold)
                    .foregroundColor(isAdminSelected ? Color.white.opacity(0.7) : .white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        isAdminSelected ? Color.clear : Color.blue.opacity(0.7)
                    )
                    .cornerRadius(10)
            }

            Button(action: {
                isAdminSelected = true
            }) {
                Text("Admin")
                    .fontWeight(isAdminSelected ? .bold : .regular)
                    .foregroundColor(isAdminSelected ? .white : Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        isAdminSelected ? Color.blue.opacity(0.7) : Color.clear
                    )
                    .cornerRadius(10)
            }
        }
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
        .animation(.easeInOut, value: isAdminSelected)
    }
}
