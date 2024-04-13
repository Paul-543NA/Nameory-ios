//
//  MemoryScreen.swift
//  Nameory
//
//  Created by Paul Festor on 13/04/2024.
//

import SwiftUI
import SwiftData

struct MemoryScreen: View {
    @State var navigationPath = NavigationPath()
    @Query(filter: Person.notRememberedTodayPredicate(),
             sort: \Person.lastRemembered
    ) var people: [Person]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                noMorePeopleView
                ForEach(people) { person in
                    PersonCardView(person: person)
                }
            }
            .navigationTitle("\(people.count) people")
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { modeToListButton } }
        }
    }
    
    private var modeToListButton: some View {
        Button("People list", systemImage: "list.bullet") {
            goToPeopleList()
        }
    }
    
    private func goToPeopleList() {
        navigationPath.append("PeopleListScreen")
    }
    
    private var noMorePeopleView: some View {
        VStack {
            Text("Welcome to MemoryView")
                .padding()
            Button("Add more people") {
                goToPeopleList()
            }
        }
        .navigationDestination(for: String.self) { str in
            if str == "PeopleListScreen" {
                PeopleListScreen(path: $navigationPath)
            }
        }
    }
}


//#Preview {
//    MemoryScreen()
//}
