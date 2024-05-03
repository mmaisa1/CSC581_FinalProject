import SwiftUI

struct ProfileView: View {
    @State private var actualName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var contactNumber = ""

    var body: some View {
        VStack{
            HStack {
        // Pushes text to the right
            Text("Profile")
                    .font(.largeTitle)
                Spacer()
                    }
            TextField("Actual Name", text: $actualName)
                .padding()
            
            TextField("Username", text: $username)
                .padding()
            
            TextField("Email", text: $email)
                .padding()
            
            TextField("Contact Number", text: $contactNumber)
                .padding()
        }
    }
}
