import SwiftUI

struct UserCredentials {
    let name: String
    let username: String
    let password: String
    let email: String
    let contact: String
}

// Static data for user credentials
var staticUsers: [UserCredentials] = [
    UserCredentials(name: "user 1", username: "user1", password: "password1", email: "user1@locale.com", contact: "1231231231"),
    UserCredentials(name: "user 2", username: "user2", password: "password2", email: "user2@locale.com", contact: "1231231234")
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
                Spacer()

                Text("Locale")
                    .font(.system(size: 48, weight: .bold, design: .serif))
                    .italic()
                    .foregroundColor(Color.white)
                    .shadow(color: .gray, radius: 4, x: 4, y: 4) // 3D effect
                    .padding(.bottom, 40)

                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(color: .gray, radius: 4, x: 4, y: 4) // 3D effect
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(color: .gray, radius: 4, x: 4, y: 4) // 3D effect
                        .autocapitalization(.none)

                    if loginFailed { // Display "Invalid user" message
                        Text("Invalid user")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 40)
                
                NavigationLink(destination: ContentView(username: username)
                                .navigationBarHidden(true) // Hide navigation bar
                                .onDisappear { // Clear input fields when navigating away
                                    self.username = ""
                                    self.password = ""
                                },
                               isActive: $isAuthenticated) {
                    Button(action: {
                        if authenticateUser() {
                            isAuthenticated = true
                            loginFailed = false // Reset login failure state
                            isClearingFields = true // Set to clear input fields
                        } else {
                            loginFailed = true
                        }
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange.opacity(0.5)) // Lightened color
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                }
                
                NavigationLink(destination: RegistrationView()
                                .navigationBarBackButtonHidden(true)
                                .onDisappear { // Clear input fields when navigating away
                                    self.username = ""
                                    self.password = ""
                                }) {
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(.purple) // Changed color to make it more visible
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .background(
                ZStack {
                    Color.pink.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 300, height: 300)
                        .position(x: 100, y: 100)
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 200, height: 200)
                        .position(x: 300, y: 400)
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 150, height: 150)
                        .position(x: 50, y: 600)
                }
            )
            .navigationTitle("")
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
