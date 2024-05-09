import SwiftUI

struct UserCredentials {
    let username: String
    let password: String
}

// Static data for user credentials
var staticUsers: [UserCredentials] = [
    UserCredentials(username: "User1", password: "password1"),
    UserCredentials(username: "User2", password: "password2")
]

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var loginFailed = false // Track login failure
    @State private var isClearingFields = false // State to clear input fields

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                
                SecureField("Password", text: $password)
                    .padding()
                
                if loginFailed { // Display "Invalid user" message
                    Text("Invalid user")
                        .foregroundColor(.red)
                }
                
                NavigationLink(destination: ContentView(username: username)
                                    .navigationBarHidden(true) // Hide navigation bar
                                    .onDisappear { // Clear input fields when navigating away
                                        self.username = ""
                                        self.password = ""
                                    },
                               isActive: $isAuthenticated) {
                    Button("Login") {
                        if authenticateUser() {
                            isAuthenticated = true
                            loginFailed = false // Reset login failure state
                            isClearingFields = true // Set to clear input fields
                        } else {
                            loginFailed = true
                        }
                    }
                    .padding()
                }
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Register")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationTitle("Login")
            .onAppear {
                if isClearingFields {
                    self.username = ""
                    self.password = ""
                    self.isClearingFields = false
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use StackNavigationViewStyle for full-screen navigation
    }
    
    // Function to authenticate the user
    func authenticateUser() -> Bool {
        for user in staticUsers {
            if user.username == username && user.password == password {
                return true
            }
        }
        // If no matching user found, return false
        return false
    }
}
