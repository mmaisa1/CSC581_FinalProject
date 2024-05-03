import SwiftUI

struct ContentView: View {
    @StateObject private var eventsViewModel = EventsViewModel()

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
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .padding()
    }
}
