
import SwiftUI

struct CreateView: View {
    @State private var isShowingAddEventDialog = false
    @State private var eventName = ""
    @State private var eventDescription = ""
    @State private var date = Date()
    @State private var venue = ""
    @State private var location = ""
    @State private var fare = ""

    @ObservedObject var eventsViewModel: EventsViewModel

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                List(eventsViewModel.events) { event in
                    NavigationLink(destination: EventDetailsView(event: event)) {
                        Text(event.name)
                    }
                }
                .navigationTitle("Your Events")
                .padding()
                
                Button(action: {
                    self.isShowingAddEventDialog.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
                }
                .sheet(isPresented: $isShowingAddEventDialog) {
                    AddEventDialog(isShowing: self.$isShowingAddEventDialog,
                                   eventName: self.$eventName,
                                   eventDescription: self.$eventDescription,
                                   date: self.$date,
                                   venue: self.$venue,
                                   location: self.$location,
                                   fare: self.$fare,
                                   eventsViewModel: eventsViewModel)
                }
                Spacer()
            }
            .navigationTitle("Create")
        }
    }
}


struct AddEventDialog: View {
    @Binding var isShowing: Bool
    @Binding var eventName: String
    @Binding var eventDescription: String
    @Binding var date: Date
    @Binding var venue: String
    @Binding var location: String
    @Binding var fare: String

    @ObservedObject var eventsViewModel: EventsViewModel

    var body: some View {
        NavigationView { // Wrap in NavigationView
            VStack {
                Text("Add Event")
                    .font(.title)
                    .padding()

                TextField("Event Name", text: $eventName)
                    .padding()

                TextField("Event Description", text: $eventDescription)
                    .padding()

                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .padding()

                TextField("Venue", text: $venue)
                    .padding()

                TextField("Location", text: $location)
                    .padding()

                TextField("Fare", text: $fare)
                    .keyboardType(.decimalPad)
                    .padding()
                
                Spacer() // Add Spacer to push content to the top
                
                HStack {
                    Button("Cancel") {
                        self.isShowing = false
                    }
                    .padding()

                    Button("Add") {
                        let newEvent = Event(name: eventName,
                                              description: eventDescription,
                                              dateTime: date,
                                              venue: venue,
                                              location: location,
                                              fare: fare)
                        self.eventsViewModel.addEvent(newEvent)
                        self.isShowing = false
                    }
                    .padding()
                }
            }
            .padding()
           // .navigationBarTitle(Text("Add Event"), displayMode: .inline) // Set navigation bar title
        }
    }
}
