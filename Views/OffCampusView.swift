//
//  OffCampusView.swift
//  Events@CU
//
//  Created by Abe Howder on 9/13/24.
//

import SwiftUI

// MARK: - Off Campus Events List View
struct OffCampusEventListView: View {
    @State private var events: [Event] = Event.offCampusSampleData
    @State private var sortMethod: SortMethod = .date // Track sorting method
    @State private var sortAscending = true // Track sort order
    
    enum SortMethod: String, CaseIterable, Identifiable {
        case date = "Date"
        case alphabetically = "Alphabetically"
        case interested = "People Interested"
        case location = "Location" // Added new sort method for location
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        VStack {
            // List of Off Campus Events
            List(events) { event in
                HStack {
                    VStack(alignment: .leading) {
                        Text(event.date)
                            .font(.headline)
                            .foregroundColor(.white) // White text for dark mode
                        Text(event.name)
                            .foregroundColor(.white) // White text for dark mode
                        Text(event.location) // Displaying location
                            .font(.subheadline)
                            .foregroundColor(.gray)
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
                    Text("Off Campus")
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
                        Button(action: { handleSort(.location) }) { // Added location sorting option
                            Label(sortMethod == .location ? (sortAscending ? "Location (Ascending)" : "Location (Descending)") : "Location", systemImage: "mappin.and.ellipse")
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
        case .location:
            events.sort { sortAscending ? $0.location < $1.location : $1.location < $0.location }
        }
    }
}

// MARK: - Event Model
struct Event: Identifiable {
    let id = UUID()
    let date: String
    let name: String
    let location: String // Added location field
    let interestedPeople: Int
    let rsvpStatus: String
    
    static let sampleData: [Event] = [
        Event(date: "Sept 15, 2024", name: "Music Festival", location: "Auditorium", interestedPeople: 50, rsvpStatus: "RSVP'd"),
        Event(date: "Sept 20, 2024", name: "Tech Talk", location: "Main Hall", interestedPeople: 120, rsvpStatus: "Not RSVPd"),
        Event(date: "Sept 25, 2024", name: "Career Fair", location: "Conference Center", interestedPeople: 200, rsvpStatus: "RSVP'd"),
        Event(date: "Oct 1, 2024", name: "Art Exhibition", location: "Gallery", interestedPeople: 80, rsvpStatus: "RSVP'd"),
        Event(date: "Oct 5, 2024", name: "Startup Pitch", location: "Startup Hub", interestedPeople: 150, rsvpStatus: "Not RSVPd"),
        Event(date: "Oct 10, 2024", name: "Networking Event", location: "Banquet Hall", interestedPeople: 90, rsvpStatus: "RSVP'd"),
        Event(date: "Oct 15, 2024", name: "Hackathon", location: "Tech Lab", interestedPeople: 180, rsvpStatus: "Not RSVPd"),
        Event(date: "Oct 20, 2024", name: "Cooking Class", location: "Kitchen Studio", interestedPeople: 60, rsvpStatus: "RSVP'd")
    ]
    
    static let offCampusSampleData: [Event] = [
        Event(date: "Sept 10, 2024", name: "Mountain Hike", location: "Mountain Base", interestedPeople: 40, rsvpStatus: "RSVP'd"),
        Event(date: "Sept 17, 2024", name: "Beach Cleanup", location: "Sandy Beach", interestedPeople: 75, rsvpStatus: "RSVP'd"),
        Event(date: "Sept 30, 2024", name: "City Concert", location: "Downtown Plaza", interestedPeople: 180, rsvpStatus: "RSVP'd"),
        Event(date: "Oct 5, 2024", name: "Local Art Show", location: "City Gallery", interestedPeople: 100, rsvpStatus: "Not RSVPd"),
        Event(date: "Oct 12, 2024", name: "Food Truck Festival", location: "Town Square", interestedPeople: 220, rsvpStatus: "RSVP'd"),
        Event(date: "Oct 20, 2024", name: "Rock Climbing Trip", location: "Cliffside Park", interestedPeople: 50, rsvpStatus: "Not RSVPd"),
        Event(date: "Oct 27, 2024", name: "Camping Retreat", location: "Forest Reserve", interestedPeople: 80, rsvpStatus: "RSVP'd"),
        Event(date: "Nov 5, 2024", name: "Local Brewery Tour", location: "City Brewery", interestedPeople: 150, rsvpStatus: "RSVP'd")
    ]
}
