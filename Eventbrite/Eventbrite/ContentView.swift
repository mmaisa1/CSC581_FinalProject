//
//  ContentView.swift
//  Eventbrite
//
//  Created by Steam Apple on 4/26/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var eventStore: EventStore
    
    var body: some View {
        TabView {
            EventListView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                }
            
            CreateEventView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Create")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
        .environmentObject(eventStore)
        .accentColor(.orange) // Set the accent color for the app
    }
}

struct EventListView: View {
    @EnvironmentObject var eventStore: EventStore
    
    var body: some View {
        NavigationView {
            List(eventStore.events) { event in
                NavigationLink(destination: EventDetailView(event: event)) {
                    EventRow(event: event)
                }
            }
            .navigationBarTitle("Upcoming Events")
            .listStyle(InsetGroupedListStyle()) // Use a grouped list style
        }
    }
}

struct EventRow: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline)
                .foregroundColor(.orange) // Set the text color
            Text(event.date, style: .date)
                .font(.subheadline)
            Text(event.location)
                .font(.subheadline)
        }
    }
}

struct EventDetailView: View {
    let event: Event
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title)
                    .foregroundColor(.orange) // Set the text color
                Text(event.date, style: .date)
                    .font(.subheadline)
                Text(event.location)
                    .font(.subheadline)
                Divider()
                Text(event.description)
                    .font(.body)
                Spacer()
                Button(action: {
                    // Handle ticket purchase
                }) {
                    Text("Buy Tickets")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationBarTitle(event.name)
    }
}

struct CreateEventView: View {
    @EnvironmentObject var eventStore: EventStore
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var location: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Event Name", text: $name)
                DatePicker("Date", selection: $date)
                TextField("Location", text: $location)
                TextEditor(text: $description)
                    .frame(minHeight: 200)
                
                Button(action: {
                    let newEvent = Event(name: name, date: date, location: location, description: description)
                    eventStore.addEvent(newEvent)
                    name = ""
                    description = ""
                }) {
                    Text("Create Event")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                }
            }
            .navigationBarTitle("Create Event")
        }
    }
}

struct ProfileView: View {
    @State private var username: String = "Rohith Raj"
    @State private var email: String = "rohithpidugu@gmail.com"
    @State private var bio: String = "iOS Developer with a passion for creating great apps."
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("profile-picture")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.orange, lineWidth: 4))
            
            Text(username)
                .font(.title)
                .foregroundColor(.orange)
            
            Text(email)
                .font(.subheadline)
            
            Text(bio)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
    }
}

struct Event: Identifiable, Codable {
    var id = UUID()
    let name: String
    let date: Date
    let location: String
    let description: String
}

class EventStore: ObservableObject {
    @Published var events: [Event] = [
        Event(name: "Swift Conference", date: Date().addingTimeInterval(86400 * 7), location: "San Francisco, CA", description: "The annual Swift conference for developers."),
        Event(name: "iOS Meetup", date: Date().addingTimeInterval(86400 * 14), location: "New York, NY", description: "Monthly meetup for iOS developers."),
        Event(name: "SwiftUI Workshop", date: Date().addingTimeInterval(86400 * 21), location: "Online", description: "Learn how to build apps with SwiftUI.")
    ]
    
    func addEvent(_ event: Event) {
        events.append(event)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EventStore())
    }
}
