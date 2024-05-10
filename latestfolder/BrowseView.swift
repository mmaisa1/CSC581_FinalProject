import SwiftUI
struct BrowseView: View {
    // Static event data
    let staticEvents: [Event] = [
        Event(name: "Event 1", description: "App launch", dateTime: Date(), venue: "Venue 1", location: "Location 1", fare: "Free"),
        Event(name: "Event 2", description: "product intro", dateTime: Date(), venue: "Venue 2", location: "Location 2", fare: "Paid"),
        Event(name: "Event 3", description: "product launch", dateTime: Date(), venue: "Venue 3", location: "Location 1", fare: "Paid")
    ]
    
    @ObservedObject var eventsViewModel: EventsViewModel
    @State private var searchText = ""
    @State private var selectedEvent: Event?
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top)
                
                List {
                    ForEach(staticEvents.filter { $0.name.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }, id: \.id) { event in
                        NavigationLink(destination: EventDetailsView(event: event)) {
                            Text(event.name)
                        }
                        .contextMenu {
                            Button(action: {
                                self.eventsViewModel.saveEvent(event)
                            }) {
                                Text("Save")
                                Image(systemName: "bookmark")
                            }
                            Button("Register") {
                            self.selectedEvent = event // Set selected event for registration
                            }
                        }
                    }
                    ForEach(eventsViewModel.events.filter { $0.name.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }, id: \.id) { event in
                        NavigationLink(destination: EventDetailsView(event: event)) {
                            Text(event.name)
                        }
                        .contextMenu {
                            Button(action: {
                                self.eventsViewModel.saveEvent(event)
                            }) {
                                Text("Save")
                                Image(systemName: "bookmark")
                            }
                            Button("Register") {
                                // Implement register action
                                self.selectedEvent = event
                            }
                        }
                    }
                }
                .navigationTitle("Events")
            }
            .sheet(item: $selectedEvent) { event in
                            RegistrationPopup(event: event, onClose: { self.selectedEvent = nil })
                        }
            //.sheet(item: $selectedEvent) { event in RegistrationPopup(event: event) }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
}

struct RegistrationPopup: View {
    var event: Event
    var onClose: () -> Void
    @State private var registrationSuccess = false

    var body: some View {
        VStack {
            Text("Event Name: \(event.name)")
            Text("Description: \(event.description)")
            Text("Date: \(formattedDate(event.dateTime))")
            Text("Venue: \(event.venue)")
            Text("Location: \(event.location)")
            Text("Fare: \(event.fare)")
            if registrationSuccess {
                Text("Registered successfully")
                    .foregroundColor(.green)
                    .padding()
            }
            Spacer()
            HStack {
                Button("Register") {
                    // Implement register action
                    registrationSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.onClose()
                    }
                }
                .padding()
                Button("Cancel") {
                    self.onClose()
                }
                .padding()
            }
        }
        .padding()
    }

    // Function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
