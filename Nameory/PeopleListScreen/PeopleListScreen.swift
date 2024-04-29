//
//  ContentView.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import SwiftUI
import SwiftData

struct PeopleListScreen: View {
    @Environment(\.modelContext) var modelContext
    @Binding var path: NavigationPath
    @State private var searchText: String = ""
    @State private var sortOrder = [SortDescriptor(\Person.dateMet, order: .reverse)]
    
    var body: some View {
        PeopleView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("People you met")
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { sortPeopleMenu } }
            .searchable(text: $searchText, placement: .toolbar)
            .overlay ( AddPersonButtonOverlay(path: $path) )
    }
    
    // MARK: - Subviews
    
    private var sortPeopleMenu: some View {
        Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
                Text("Name")
                    .tag([SortDescriptor(\Person.name)])
                
                Text("Recently met")
                    .tag([SortDescriptor(\Person.dateMet, order: .reverse)])
            }
        }
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
