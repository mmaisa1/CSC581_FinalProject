import SwiftUI
struct FavoritesView: View {
    @ObservedObject var eventsViewModel: EventsViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top)
                
                List(eventsViewModel.savedEvents.filter { $0.name.localizedCaseInsensitiveContains(searchText) || searchText.isEmpty }) { event in
                    NavigationLink(destination: EventDetailsView(event: event)) {
                        Text(event.name)
                    }
                }
                .navigationTitle("Favorites")
            }
        }
    }
}
