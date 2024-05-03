import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isShowingAddEventDialog = true

    var body: some View {
        NavigationView {
            VStack {
                Text("login")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                
                SecureField("Password", text: $password)
                    .padding()
                
                Button("Login") {
                    // Perform login action
                }
                .padding()

                Button("Forgot Password") {
                    // Navigate to forgot password screen
                }
                .padding()
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Register")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationTitle("Locale")
        }
    }
}
