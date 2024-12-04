import SwiftUI

struct LoginScreen: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isAdminSelected = false

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
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            // Handle login logic
                        }) {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(8)
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
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .preferredColorScheme(.dark)
    }
}
