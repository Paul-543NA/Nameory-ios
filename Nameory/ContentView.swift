//
//  ContentView.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @State private var searchText: String = ""
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    
    var body: some View {
        NavigationStack(path: $path) {
            PropleView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("Nameory")
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person, navigationPath: $path)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            Button("Add person", systemImage: "plus", action: addPerson)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Back to cards", systemImage: "person.2.crop.square.stack", action: { print("TODO: Move to cards view") })
                    }
                }
                .searchable(text: $searchText, placement: .toolbar)
        }
    }
    
    func addPerson() {
        let newPerson = Person(name: "", email: "", notes: "")
        modelContext.insert(newPerson)
        path.append(newPerson)
    }
    
}

//#Preview {
//    do {
//        let previewer = Previewer()
//        return ContentView().modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to generate preview with error \(error.localizedDescription)")
//    }
//}
