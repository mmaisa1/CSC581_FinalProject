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
                                    Button("Submit") {
                                        // Perform registration action
                                        // Save user details
                                        // Navigate to LoginView
                                        presentationMode.wrappedValue.dismiss()
                                        let profileView = ProfileView(name: name, username: username, email: email, contactNumber: contactNumber)
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                            // Get the window associated with the scene
                                            if let window = windowScene.windows.first {
                                            // Present the ProfileView modally
                                                window.rootViewController?.present(UIHostingController(rootView: profileView), animated: true, completion: nil)
                                            }
                                        }
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
}
