//
//  PropleView.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import SwiftUI
import SwiftData

struct PropleView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    
    var body: some View {
        List {
            ForEach(people) { person in
                NavigationLink(value: person) {
                    PersonListItemView(person: person)
                }
            }.onDelete(perform: deletePeople)
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Person>]) {
        // _people accesses the Query itself rather than the array that results of the query
        // #Predicate translates swift code to SQL at runtime
        _people = Query(filter: #Predicate { person in
            if searchString.isEmpty {
                true
            } else {
                // Nore that these predicates are performed in order, perhapsnworth putting the most efficient ones first
                person.name.localizedStandardContains(searchString)
                || person.notes.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    func deletePeople(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

//#Preview {
//    do {
//        let previewer = Previewer()
//        return PropleView(sortOrder: [SortDescriptor<Person>]())
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to generate preview with error \(error.localizedDescription)")
//    }
//}
