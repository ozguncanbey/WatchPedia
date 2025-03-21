import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CreateAccountScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
                VStack(spacing: 15) {
                    Button(action: {
                        // Handle sign-up logic
                        createAccount()
                    }) {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    errorMessage = ""
                                }
                            }
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.white)
                            .font(.footnote)
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Sign In")
                                .foregroundColor(Color.blue)
                                .font(.footnote)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .toolbar(.hidden, for: .automatic)
            .padding()
        }
    }
    
    private func createAccount() {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields"
            showError = true
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 digits"
            showError = true
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            showError = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                errorMessage = error?.localizedDescription ?? "Something wrong"
                showError = true
            } else {
                storeUserInformations()
                dismiss()
            }
        }
    }
    
    private func storeUserInformations() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["username" : username, "email" : email, "password" : password, "isAdmin" : false, "uid" : uid] as [String : Any]
        Firestore.firestore().collection("users").document(uid).setData(userData) { error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
            .preferredColorScheme(.dark)
    }
}
