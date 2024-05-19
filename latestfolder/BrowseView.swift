import SwiftUI

struct BrowseView: View {
    // Static event data
    let staticEvents: [Event] = [
        Event(name: "Event 1", description: "App launch", dateTime: Date(), venue: "Venue 1", location: "Location 1", fare: "Free"),
        Event(name: "Event 2", description: "Product intro", dateTime: Date(), venue: "Venue 2", location: "Location 2", fare: "Paid"),
        Event(name: "Event 3", description: "Product launch", dateTime: Date(), venue: "Venue 3", location: "Location 1", fare: "Paid")
    ]
    
    @ObservedObject var eventsViewModel: EventsViewModel
    @State private var searchText = ""
    @State private var selectedEvent: Event?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Happenings")
                    .font(.custom("Arial", size: 24))
                    .italic()
                    .padding(.top, 10)
                    .padding(.leading, 10)
                
                SearchBar(text: $searchText)
                    .padding(.top, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(staticEvents.filter { $0.name.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }, id: \.id) { event in
                            EventRowView(event: event)
                                .onTapGesture {
                                    self.selectedEvent = event // Set selected event for registration
                                }
                                .contextMenu {
                                    Button(action: {
                                        self.eventsViewModel.saveEvent(event)
                                    }) {
                                        Text("Save")
                                        Image(systemName: "bookmark")
                                    }
                                }
                        }
                        ForEach(eventsViewModel.events.filter { $0.name.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }, id: \.id) { event in
                            EventRowView(event: event)
                                .onTapGesture {
                                    self.selectedEvent = event // Set selected event for registration
                                }
                        }
                    }
                    .padding()
                }
            }
            .sheet(item: $selectedEvent) { event in
                RegistrationPopup(event: event, onClose: { self.selectedEvent = nil })
            }
            .navigationBarHidden(true) // Hide navigation bar
        }
    }
}


struct EventRowView: View {
    var event: Event
    
    var body: some View {
        HStack(alignment: .top) {
            // Placeholder image, replace with actual event image
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.headline)
                
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct RegistrationPopup: View {
    var event: Event
    var onClose: () -> Void
    @State private var registrationSuccess = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Event Name: \(event.name)")
                .font(.title2)
                .padding(.top)

            Text("Description: \(event.description)")
                .font(.body)
            
            Text("Date: \(formattedDate(event.dateTime))")
                .font(.body)

            Text("Venue: \(event.venue)")
                .font(.body)

            Text("Location: \(event.location)")
                .font(.body)

            Text("Fare: \(event.fare)")
                .font(.body)

            if registrationSuccess {
                Text("Registered successfully")
                    .foregroundColor(.green)
                    .padding()
            }

            HStack {
                Button("Register") {
                    // Implement register action
                    registrationSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.onClose()
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Cancel") {
                    self.onClose()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 10)
    }

    // Function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
