import SwiftUI

// Event model
struct Event: Identifiable {
    let id = UUID()
    let name: String
    let details: String
    let location: String
    let image: String
}

// User model
struct User {
    var reservations: [Event] = []
    var favorites: [Event] = []
}

// Main view
struct ContentView: View {
    @State private var selectedTab = 0
    @State private var user = User()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView(user: $user)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }.tag(0)
            
            NavigationView {
                ReservationsView(user: $user)
            }
            .tabItem {
                Image(systemName: "ticket.fill")
                Text("Reservations")
            }.tag(1)
            
            NavigationView {
                FavoritesView(user: $user)
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }.tag(2)
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }.tag(3)
        }
    }
}

// Home tab view
struct HomeView: View {
    @Binding var user: User
    @State private var searchText = ""
    let events = (1...5).map { Event(name: "Event \($0)", details: "Details for event \($0)", location: "Location \($0)", image: "Image\($0)") }

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            ScrollView {
                ForEach(events.filter { searchText.isEmpty ? true : $0.name.contains(searchText) }) { event in
                    NavigationLink(destination: EventDetailView(event: event, user: $user)) {
                        EventRow(event: event)
                    }
                }
            }
        }
    }
}

// Event row view
struct EventRow: View {
    let event: Event

    var body: some View {
        HStack {
            Image(event.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text(event.name)
            Spacer()
        }
    }
}

// Event detail view
struct EventDetailView: View {
    let event: Event
    @Binding var user: User

    var body: some View {
        VStack {
            Image(event.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            Text(event.name)
                .font(.title)
                .padding(.top)
            Text(event.details)
                .padding()
            Text(event.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Button(action: {
                user.reservations.append(event)
            }) {
                Text("Book")
            }
            Button(action: {
                user.favorites.append(event)
            }) {
                Text("Like")
            }
        }
        .padding()
    }
}

// Reservations tab view
struct ReservationsView: View {
    @Binding var user: User

    var body: some View {
        ScrollView {
            ForEach(user.reservations) { event in
                EventRow(event: event)
            }
        }
    }
}

// Favorites tab view
struct FavoritesView: View {
    @Binding var user: User

    var body: some View {
        ScrollView {
            ForEach(user.favorites) { event in
                EventRow(event: event)
            }
        }
    }
}

// Profile tab view
struct ProfileView: View {
    var body: some View {
        Text("Profile Tab")
    }
}

// Search bar view
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search...", text: $text)
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}

