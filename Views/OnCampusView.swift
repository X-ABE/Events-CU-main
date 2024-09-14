//
//  File.swift
//  Events@CU
//
//  Created by Abe Howder on 9/13/24.
//

import SwiftUI
// MARK: - Event List View (On Campus Events)
struct EventListView: View {
    @State private var events: [Event] = Event.sampleData
    @State private var sortMethod: SortMethod = .date // Track sorting method
    @State private var sortAscending = true // Track sort order
    
    enum SortMethod: String, CaseIterable, Identifiable {
        case date = "Date"
        case alphabetically = "Alphabetically"
        case interested = "People Interested"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        VStack {
            // List of On Campus Events
            List(events) { event in
                HStack {
                    VStack(alignment: .leading) {
                        Text(event.date)
                            .font(.headline)
                            .foregroundColor(.white) // White text for dark mode
                        Text(event.name)
                            .foregroundColor(.white) // White text for dark mode
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(event.interestedPeople) Interested")
                            .font(.subheadline)
                            .foregroundColor(.gray) // Adjusted color for dark mode
                        Text(event.rsvpStatus)
                            .font(.subheadline)
                            .foregroundColor(event.rsvpStatus == "RSVP'd" ? .green : .gray)
                    }
                }
                .padding()
                .listRowBackground(Color.black) // Make the background of each row dark
            }
            .listStyle(PlainListStyle()) // Customize list style if needed
        }
        .background(Color.black) // Black background behind the list
        .navigationBarTitleDisplayMode(.inline) // Set inline title
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack { // Use HStack to move text more to the left
                    Text("On Campus")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold)) // Larger text with bold weight
                    Spacer()
                }
            }
            
            // Sort button with opaque background
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.5)) // Opaque background
                        .frame(height: 40)
                    
                    Menu {
                        Button(action: { handleSort(.date) }) {
                            Label(sortMethod == .date ? (sortAscending ? "Date (Ascending)" : "Date (Descending)") : "Date", systemImage: "calendar")
                        }
                        Button(action: { handleSort(.alphabetically) }) {
                            Label(sortMethod == .alphabetically ? (sortAscending ? "Alphabetically (Ascending)" : "Alphabetically (Descending)") : "Alphabetically", systemImage: "textformat")
                        }
                        Button(action: { handleSort(.interested) }) {
                            Label(sortMethod == .interested ? (sortAscending ? "People Interested (Ascending)" : "People Interested (Descending)") : "People Interested", systemImage: "person.3")
                        }
                    } label: {
                        HStack {
                            Text("Sort")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        .frame(height: 40)
                    }
                }
            }
        }
    }
    
    private func handleSort(_ method: SortMethod) {
        if sortMethod == method {
            sortAscending.toggle()
        } else {
            sortMethod = method
            sortAscending = true
        }
        sortEvents()
    }
    
    private func sortEvents() {
        switch sortMethod {
        case .date:
            events.sort { sortAscending ? $0.date < $1.date : $0.date > $1.date }
        case .alphabetically:
            events.sort { sortAscending ? $0.name < $1.name : $0.name > $1.name }
        case .interested:
            events.sort { sortAscending ? $0.interestedPeople < $1.interestedPeople : $1.interestedPeople < $0.interestedPeople }
        }
    }
}
