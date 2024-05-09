import SwiftUI

struct BrowseView: View {
    @ObservedObject var eventsViewModel: EventsViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top)
                
                List(eventsViewModel.filteredEvents(for: searchText.isEmpty ? "" : searchText)) { event in
                    NavigationLink(destination: EventDetailsView(event: event)) {
                        Text(event.name)
                    }
                }
                .navigationTitle("Events")
            }
        }
    }
}

// SearchBar representing the search bar
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
