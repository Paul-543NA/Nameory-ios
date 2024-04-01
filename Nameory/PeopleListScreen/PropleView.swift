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
                || person.email.localizedStandardContains(searchString)
                || person.notes.localizedStandardContains(searchString)
            }
        }, sort: [SortDescriptor(\Person.name)])
//        if people.count < 1 {
//    
//            let person2 = Person(name: "John Doe", email: "john.doe@hismail.com", notes: "Likes to play rugby, a true lad")
//            person2.avatar = Avatar(gender: .male, skinTone: .regular7, hairColor: .regular5)
//            modelContext.insert(person2)
//    
//            let person3 = Person(name: "Jane Smith", email: "jane.smith@example.com", notes: "Vegan, loves nature and outdoor activities")
//            person3.avatar = Avatar(gender: .female, skinTone: .regular3, hairColor: .regular2)
//            modelContext.insert(person3)
//    
//            let person4 = Person(name: "Alex Johnson", email: "alex.j@example.net", notes: "Tech enthusiast, blogger")
//            person4.avatar = Avatar(gender: .female, skinTone: .vivid3, hairColor: .regular4)
//            modelContext.insert(person4)
//    
//            let person5 = Person(name: "Sam Rivera", email: "sam.r@example.org", notes: "Architect, interested in sustainable design")
//            person5.avatar = Avatar(gender: .male, skinTone: .regular6, hairColor: .regular3)
//            modelContext.insert(person5)
//        }
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
