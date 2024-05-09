import SwiftUI

struct ProfileView: View {
    var username: String
    //@Binding var isLoggedIn: Bool // Binding to track the authentication state

    var body: some View {
        VStack {
            Text("Profile").font(.largeTitle).padding(20)
            TextField("Username", text: .constant(username))
                .padding()
            
            TextField("Email", text: .constant("dummy@example.com"))
                .padding()
            
            TextField("Contact Number", text: .constant("1234567890"))
                .padding()
            
            /*Button("Logout") {
                // Perform logout action by setting isLoggedIn to false
                isLoggedIn = false
            }
            .foregroundColor(.red)
            .padding()*/
        }
    }
}


