import SwiftUI
import AuthenticationServices

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isCreateAccountShown: Bool = false
    @State private var createdUsername: String = ""
    @State private var createdPassword: String = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Login")
                    .font(.custom("Academy Engraved LET Plain:1.0", size: 50))
                    .foregroundColor(.white)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.clear) // Set background to clear
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.clear) // Set background to clear
                    .padding()
                
                Button(action: {
                    // Add your login logic here
                    // Validate the username and password against your stored data or authentication system
                    
                    // Example: Check if username is "admin" and password is "password"
                    if username == "admin" && password == "password" {
                        showAlert(title: "Success", message: "Login successful!")
                    } else {
                        showAlert(title: "Error", message: "Invalid credentials.")
                    }
                }) {
                    Text("Link")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    isCreateAccountShown = true
                }) {
                    Text("Sign Up")
                        .font(.custom("Academy Engraved LET Plain:1.0", size: 25))
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $isCreateAccountShown) {
                    ZStack {
                        Color.white.edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            Text("Sign Up")
                                .font(.custom("Academy Engraved LET Plain:1.0", size: 25))
                                .foregroundColor(.black)
                            
                            TextField("Username", text: $createdUsername)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white) // Set background to clear
                                .padding()
                            
                            SecureField("Password", text: $createdPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.white) // Set background to clear
                                .padding()
                            
                            Button(action: {
                                // Add your create account logic here
                                // Store the createdUsername and createdPassword in your database or authentication system
                                
                                showAlert(title: "Success", message: "Account created successfully!")
                                
                                // Reset the create account fields
                                createdUsername = ""
                                createdPassword = ""
                                isCreateAccountShown = false
                            }) {
                                Text("Create")
                                    .font(.custom("Academy Engraved LET Plain:1.0", size: 25))
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.clear)
                                    .cornerRadius(10)
                            }
                            .padding()
                            
                            SignInWithAppleButton(
                                .signIn,
                                onRequest: { request in
                                    // Add your Sign in with Apple logic here
                                    // Handle the Apple ID authorization request
                                    request.requestedScopes = [.fullName, .email]
                                },
                                onCompletion: { result in
                                    // Add your Sign in with Apple completion handling here
                                    switch result {
                                    case .success(let authorization):
                                        // Handle the successful authorization
                                        print("Sign in with Apple successful")
                                        // You can access the user's Apple ID credentials from `authorization.credential`
                                    case .failure(let error):
                                        // Handle the error
                                        print("Sign in with Apple failed: \(error.localizedDescription)")
                                    }
                                }
                            )
                            .signInWithAppleButtonStyle(.black)
                            .frame(width: 280, height: 50)
                            .padding()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                }
                
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        // Add your Sign in with Apple logic here
                        // Handle the Apple ID authorization request
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        // Add your Sign in with Apple completion handling here
                        switch result {
                        case .success(let authorization):
                            // Handle the successful authorization
                            print("Sign in with Apple successful")
                            // You can access the user's Apple ID credentials from `authorization.credential`
                        case .failure(let error):
                            // Handle the error
                            print("Sign in with Apple failed: \(error.localizedDescription)")
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(width: 280, height: 50)
                .padding()
                
            }
            .padding()
            .background(Color.clear)
            .cornerRadius(40)
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let viewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

