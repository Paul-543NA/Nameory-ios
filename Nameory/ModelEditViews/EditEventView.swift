//
//  EditEventView.swift
//  Nameory
//
//  Created by Paul Festor on 18/03/2024.
//

import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event
    var body: some View {
        Form {
            TextField("Event Name", text: $event.name)
            TextField("Event location", text: $event.location)
        }
        .navigationTitle("Edit event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditEventView(event: previewer.event).modelContainer(previewer.container)
    } catch {
        return Text("Failed to generate preview with error \(error.localizedDescription)")
    }
}
