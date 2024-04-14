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
    // A Query to extrct all the people with a memory date in the past and sort them such that the ones which have already been seen and missed today are put last
    @Query(filter: Person.notRememberedTodayPredicate(),
             sort: [
                SortDescriptor(\Person.nTestedToday, order: .reverse)
             ]
    ) var people: [Person]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                noMorePeopleView
                ForEach(people) { person in
                    PersonCardView(person: person)
                }
            }
            .navigationTitle("What is their name?")
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
            Text("You're done remembering people for today!")
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
