import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SettingsScreen: View {
    @Binding var isCurrentUserExists: Bool
    @State private var currentUser = Auth.auth().currentUser
    @State private var username = ""
    @State private var email = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var successMessage = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // User Information Section
                VStack(alignment: .leading, spacing: 15) {
                    // Username
                    settingsRow(
                        icon: "person.fill",
                        title: "Username",
                        value: currentUser?.displayName ?? "N/A",
                        isEditing: $isEditing
                    )
                    
                    // Email
                    settingsRow(
                        icon: "envelope.fill",
                        title: "Email",
                        value: currentUser?.email ?? "N/A",
                        isEditing: $isEditing
                    )
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                
                // Change Password Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Change Password")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    SecureField("New Password", text: $newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm New Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: changePassword) {
                        Text("Update Password")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                
                // Error/Success Messages
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if !successMessage.isEmpty {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .padding()
                }
                
                // Logout Button
                Button(action: logout) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Settings")
            .padding()
            .background(Color.black.opacity(0.9))
        }
    }
    
    // Settings Row View
    func settingsRow(icon: String, title: String, value: String, isEditing: Binding<Bool>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(value)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Edit Button (Placeholder - implement full edit functionality as needed)
            Button(action: { isEditing.wrappedValue.toggle() }) {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
            }
        }
    }
    
    // Logout Function
    func logout() {
        do {
            try Auth.auth().signOut()
            isCurrentUserExists = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // Change Password Function
    func changePassword() {
        // Reset messages
        errorMessage = ""
        successMessage = ""
        
        // Validate password
        guard !newPassword.isEmpty else {
            errorMessage = "Password cannot be empty"
            return
        }
        
        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        // Firebase password change
        currentUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                successMessage = "Password updated successfully"
                newPassword = ""
                confirmPassword = ""
            }
        }
    }
}

#Preview {
    SettingsScreen(isCurrentUserExists: .constant(false))
        .preferredColorScheme(.dark)
}
