import SwiftUI

struct ContentView: View {
    @StateObject private var eventsViewModel = EventsViewModel()
    var username: String // Receive the authenticated username

    var body: some View {
        ZStack { // Use ZStack to layer background and content
            //Color.blue.opacity(0.4)
                //.edgesIgnoringSafeArea(.all)

            VStack {
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

                    // Favorites Tab
                    FavoritesView(eventsViewModel: eventsViewModel)
                        .tabItem {
                            Image(systemName: "bookmark")
                            Text("Saved")
                        }

                    // Profile Tab
                    ProfileView(username: username)
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                .background(Color.pink.opacity(0.4)) // Set background color for TabView
            }
        }
    }
}
