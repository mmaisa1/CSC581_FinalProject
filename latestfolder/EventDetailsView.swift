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
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title)
                    .padding(.bottom)

                Text(event.description)
                    .padding(.bottom)

                Text("Date: \(formattedDate(event.dateTime))")
                    .padding(.bottom)

                Text("Venue: \(event.venue)")
                    .padding(.bottom)

                Text("Location: \(event.location)")
                    .padding(.bottom)

                Text("Fare: \(event.fare)")
                    .padding(.bottom)
            }
           
            .navigationTitle("Event Details")
        }

        // Function to format the date
        private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
}

// Observable object to hold events
class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
        @Published var savedEvents: [Event] = []

        // Function to save an event
        func saveEvent(_ event: Event) {
            savedEvents.append(event)
        }

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

