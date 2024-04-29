//
//  EventsSelectionScreen.swift
//  Nameory
//
//  Created by Paul Festor on 22/04/2024.
//

import SwiftUI
import SwiftData

struct EventsSelectionScreen: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Bindable var person: Person

    @State private var searchText: String = ""
    @State private var creationOverlayShown: Bool = false
    @State private var newEventName: String = ""
    @FocusState private var isKeyboardFocusedOnOverlay: Bool

    var body: some View {
        EventsListView(searchString: searchText, onSelectEvent: onSelectEvent)
            .navigationTitle("Events")
            .searchable(text: $searchText, placement: .toolbar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus", action: showAddEventOverlay)
                }
            }
            .overlay ( eventsCraationOverlay )
    }
    
    @ViewBuilder var eventsCraationOverlay: some View {
        if creationOverlayShown {
            ZStack {
                Color(uiColor: .systemBackground).opacity(0.3)
                    .onTapGesture { cancelNewEvent() }
                VStack {
                    Spacer()
                    eventInputView
                        .background(Color(uiColor: .secondarySystemBackground))
                        .padding()
                        .clipShape(.rect(cornerRadius: 10))
                    Spacer()
                }
            }
            .animation(.easeInOut, value: creationOverlayShown)
        }
    }
    
    private var eventInputView: some View {
        VStack(alignment: .center) {
            Text("New event")
                .font(.title2)
                .padding()
            TextField("Name your item...", text: $newEventName)
                .focused($isKeyboardFocusedOnOverlay)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isKeyboardFocusedOnOverlay = true
                    }
                }
                .onSubmit { confirmNewEvent() }
                .frame(maxWidth: .infinity)
                .padding()
            HStack {
                Spacer()
                Button("Cancel", action: cancelNewEvent)
                Spacer()
                Button("Ok", action: confirmNewEvent)
                Spacer()
            }.padding()
        }
    }
    
    private func showAddEventOverlay() {
        newEventName = ""
        withAnimation { creationOverlayShown = true }
    }
    
    private func cancelNewEvent() {
        newEventName = ""
        withAnimation {
            isKeyboardFocusedOnOverlay = false
            creationOverlayShown = false
        }
    }
    
    private func confirmNewEvent() {
        let event = Event(name: newEventName, location: "")
        person.metAt = event
        newEventName = ""
        withAnimation {
            isKeyboardFocusedOnOverlay = false
            creationOverlayShown = false
        }
    }
    
    private func onSelectEvent(event: Event) {
        person.metAt = event
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct EventsListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var events: [Event]
    var onSelectEvent: (Event) -> ()
    
    var body: some View {
        List {
            ForEach(events) { event in
                Text(event.name)
                    .onTapGesture {
                        onSelectEvent(event)
                    }
            }.onDelete(perform: deleteEvent)
        }
    }
    
    init(searchString: String = "", onSelectEvent: @escaping (Event) -> ()) {
        self.onSelectEvent = onSelectEvent
        // Sort events in alphabetical order of their names
        let sortOrder: [SortDescriptor<Event>] = [
            .init(\Event.name, order: .forward)
        ]
        
        // Build the events query
        _events = Query(filter: #Predicate { event in
            if searchString.isEmpty {
                true
            } else {
                event.name.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        for offset in offsets {
            let event = events[offset]
            modelContext.delete(event)
        }
    }
}

