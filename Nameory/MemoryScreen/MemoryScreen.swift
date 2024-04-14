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
    @AppStorage("showOnboardingView") var showOnboardingView = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                noMorePeopleView
                ForEach(people) { person in
                    PersonCardView(person: person)
                }
            }
            .navigationTitle("What is their name?")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { infoButton }
                ToolbarItem(placement: .navigationBarTrailing) { modeToListButton }
            }
            .navigationDestination(for: String.self) { str in
                if str == "PeopleListScreen" {
                    PeopleListScreen(path: $navigationPath)
                }
            }
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person, navigationPath: $navigationPath)
            }
            .overlay ( AddPersonButtonOverlay(path: $navigationPath) )
        }
    }
    
    private var modeToListButton: some View {
        Button("People list", systemImage: "list.bullet") {
            goToPeopleList()
        }
    }
    
    private var infoButton: some View {
        Button("Show information", systemImage: "questionmark.circle") {
            withAnimation { showOnboardingView = true }
        }
    }
    
    private func goToPeopleList() {
        navigationPath.append("PeopleListScreen")
    }
    
    private var noMorePeopleView: some View {
        VStack {
            Spacer()
            Text("You're done remembering people for today!")
                .padding()
            Button("Add more people") {
                goToPeopleList()
            }
            Spacer()
        }
    }
}


//#Preview {
//    MemoryScreen()
//}
