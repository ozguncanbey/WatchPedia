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
    @State private var passwordLength: Int = 6
    @State private var isEditingUsername = false
    @State private var isEditingEmail = false
    @State private var isEditingPassword = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // User Information Section
                VStack(alignment: .leading, spacing: 15) {
                    // Username
                    if isEditingUsername {
                        editingRow(
                            title: "New Username",
                            text: $username,
                            saveAction: updateUsername,
                            cancelAction: { isEditingUsername = false }
                        )
                    } else {
                        settingsRow(
                            icon: "person.fill",
                            title: "Username",
                            value: username.isEmpty ? (currentUser?.displayName ?? "N/A") : username,
                            isEditing: $isEditingUsername
                        )
                    }
                    
                    // Email
                    if isEditingEmail {
                        editingRow(
                            title: "New Email",
                            text: $email,
                            saveAction: updateEmail,
                            cancelAction: { isEditingEmail = false }
                        )
                    } else {
                        settingsRow(
                            icon: "envelope.fill",
                            title: "Email",
                            value: currentUser?.email ?? "N/A",
                            isEditing: $isEditingEmail
                        )
                    }
                    
                    // Password
                    if isEditingPassword {
                        VStack(alignment: .leading, spacing: 10) {
                            SecureField("New Password", text: $newPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            SecureField("Confirm New Password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            HStack {
                                Button("Save Password") {
                                    changePassword()
                                }
                                .buttonStyle(.borderedProminent)
                                
                                Button("Cancel") {
                                    isEditingPassword = false
                                    newPassword = ""
                                    confirmPassword = ""
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    } else {
                        settingsRow(
                            icon: "lock.fill",
                            title: "Password",
                            value: String(repeating: "•", count: passwordLength),
                            isEditing: $isEditingPassword
                        )
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                
                // Error/Success Messages
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                errorMessage = ""
                            }
                        }
                }
                
                if !successMessage.isEmpty {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                successMessage = ""
                            }
                        }
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
            .onAppear {
                fetchUsernameFromFirestore()
                fetchPasswordLength()
            }
        }
    }
    
    // Settings Row View
    private func settingsRow(icon: String, title: String, value: String, isEditing: Binding<Bool>) -> some View {
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
            
            Button(action: { isEditing.wrappedValue.toggle() }) {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
            }
        }
    }
    
    // Editing Row View
    private func editingRow(title: String, text: Binding<String>, saveAction: @escaping () -> Void, cancelAction: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField(title, text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Save") {
                    saveAction()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Cancel") {
                    cancelAction()
                }
                .buttonStyle(.bordered)
            }
        }
    }
    
    // Clear Message After Delay
    private func clearMessageAfterDelay(message: String, setter: @escaping (String) -> Void) {
        guard !message.isEmpty else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            setter("")
        }
    }
    
    // Fetch Username from Firestore
    private func fetchUsernameFromFirestore() {
        guard let uid = currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                errorMessage = "Failed to fetch username: \(error.localizedDescription)"
                return
            }
            
            if let data = snapshot?.data(), let fetchedUsername = data["username"] as? String {
                username = fetchedUsername
            }
        }
    }
    
    private func fetchPasswordLength() {
        guard let uid = currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { document, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else if let document = document, let password = document.data()?["password"] as? String {
                passwordLength = password.count
            }
        }
    }
    
    
    // Logout Function
    private func logout() {
        do {
            try Auth.auth().signOut()
            isCurrentUserExists = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // Change Password Function
    private func changePassword() {
        errorMessage = ""
        successMessage = ""
        
        guard !newPassword.isEmpty else {
            errorMessage = "Password cannot be empty"
            return
        }
        
        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        
        currentUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                updateFirestore(field: "password", value: newPassword)
                successMessage = "Password updated successfully"
                newPassword = ""
                confirmPassword = ""
                isEditingPassword = false
            }
        }
    }
    
    // Update Username Function
    private func updateUsername() {
        guard !username.isEmpty else {
            errorMessage = "Username cannot be empty"
            return
        }
        
        let changeRequest = currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                successMessage = "Username updated successfully"
                updateFirestore(field: "username", value: username)
                isEditingUsername = false
            }
        }
    }
    
    // Update Email Function
    private func updateEmail() {
        guard !email.isEmpty else {
            errorMessage = "Email cannot be empty"
            return
        }
        
        currentUser?.updateEmail(to: email) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                successMessage = "Email updated successfully"
                updateFirestore(field: "email", value: email)
                isEditingEmail = false
            }
        }
    }
    
    // Update Firestore Function
    private func updateFirestore(field: String, value: String) {
        guard let uid = currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).updateData([field: value]) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                successMessage = "\(field.capitalized) updated successfully"
            }
        }
    }
}


#Preview {
    SettingsScreen(isCurrentUserExists: .constant(false))
        .preferredColorScheme(.dark)
}
