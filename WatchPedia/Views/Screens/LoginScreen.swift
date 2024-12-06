import SwiftUI
import FirebaseAuth

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isAdminSelected = false
    @State private var errorMessage = ""
    @State private var showError = false
    
    @Binding var isCurrentUserExists: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    CustomPicker(isAdminSelected: $isAdminSelected)
                    
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .privacySensitive(false)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            // Handle login logic
                            login()
                        }) {
                            Text("Sign In")
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
                        }
                        
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                                .font(.footnote)
                            
                            NavigationLink(destination: CreateAccountScreen()) {
                                Text("Create Account")
                                    .foregroundColor(Color.blue)
                                    .font(.footnote)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            showError = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                errorMessage = error?.localizedDescription ?? "Something wrong"
                showError = true
            } else {
                isCurrentUserExists = true
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(isCurrentUserExists: .constant(false))
            .preferredColorScheme(.dark)
    }
}
