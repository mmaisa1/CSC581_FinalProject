import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var contactNumber = ""
    @State private var password = ""
    @State private var errorMessage = "" // Error message state
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
                
                Text(errorMessage) // Display error message
                    .foregroundColor(.red)
                    .padding()
                    .opacity(errorMessage.isEmpty ? 0 : 1) // Hide if empty
                
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
        // Check if username and password fields are empty
        if username.isEmpty || password.isEmpty {
            errorMessage = "Empty fields!" // Set error message
            return
        }
        
        // Create a new UserCredentials object and append it to staticUsers array
        let newUser = UserCredentials(name: name, username: username, password: password, email: email, contact: contactNumber)
        staticUsers.append(newUser)
        
        // Dismiss the registration view
        presentationMode.wrappedValue.dismiss()
    }
}
