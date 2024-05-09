import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var contactNumber = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                
                TextField("Email", text: $email)
                    .padding()
                
                TextField("Contact Number", text: $contactNumber)
                    .padding()
                
                SecureField("Password", text: $password)
                    .padding()
                
                HStack {
                    Button(action: {
                        registerUser() // Call the registerUser function
                    }) {
                        Text("Submit")
                            .padding()
                    }
                    .padding()
                    
                    Button("Cancel") {
                        // Navigate back to LoginView without registration
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .foregroundColor(.red) // Change color to differentiate from submit button
                }
            }
        }.navigationTitle("Register")
    }
    
    // Function to handle registration action
    func registerUser() {
        // Create a new UserCredentials object and append it to staticUsers array
        let newUser = UserCredentials(username: username, password: password)
        staticUsers.append(newUser)
        
        // Dismiss the registration view
        presentationMode.wrappedValue.dismiss()
    }
}
