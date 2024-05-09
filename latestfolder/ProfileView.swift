import SwiftUI

struct ProfileView: View {
    var username: String
    @State private var isLoggingOut = false // State to track logout action

    var body: some View {
        NavigationView {
            VStack {
                Text("Profile").font(.largeTitle).padding(20)
                TextField("Username", text: .constant(username))
                    .padding()
                
                TextField("Email", text: .constant("dummy@example.com"))
                    .padding()
                
                TextField("Contact Number", text: .constant("1234567890"))
                    .padding()
                
                Button("Logout") {
                    // Perform logout action
                    isLoggingOut = true
                }
                .foregroundColor(.red)
                .padding()
                .fullScreenCover(isPresented: $isLoggingOut) {
                    LoginView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use StackNavigationViewStyle for full-screen navigation
    }
}
