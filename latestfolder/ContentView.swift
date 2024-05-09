import SwiftUI

struct ContentView: View {
    //@State private var isLoggedIn = true // Initial value for the authentication state
    @StateObject private var eventsViewModel = EventsViewModel()
    var username: String // Receive the authenticated username

    var body: some View {
        TabView {
            // Browse Tab
            BrowseView(eventsViewModel: eventsViewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Browse")
                }

            // Create Tab
            CreateView(eventsViewModel: eventsViewModel)
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Create")
                }

            // Profile Tab
            ProfileView(username: username) // Pass isLoggedIn as a binding
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .padding()
        /*.fullScreenCover(isPresented: $isLoggedIn) {
            LoginView()
        }*/
    }
}
