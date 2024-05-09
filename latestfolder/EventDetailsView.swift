import SwiftUI

// Model for Event
struct Event: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var dateTime: Date
    var venue: String
    var location: String
    var fare: String
}

struct EventDetailsView: View {
    var event: Event

    var body: some View {
        Text(event.name)
            .navigationTitle("Event Details")
        Text(event.description)
        Text(event.venue)
        Text(event.location)
        Text(event.fare)
    }
}

// Observable object to hold events
class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []

    func addEvent(_ event: Event) {
        events.append(event)
    }

    func filteredEvents(for query: String) -> [Event] {
        guard !query.isEmpty else {
            return events
        }
        return events.filter { $0.name.localizedCaseInsensitiveContains(query) || $0.description.localizedCaseInsensitiveContains(query) }
    }
}
