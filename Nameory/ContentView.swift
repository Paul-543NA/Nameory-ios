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
    @State private var sortOrder = [SortDescriptor(\Person.dateMet, order: .reverse)]
    
    var body: some View {
        NavigationStack(path: $path) {
            PropleView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("Nameory")
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person, navigationPath: $path)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            Button("Back", systemImage: "arrow.left", action: goBack )
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
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
                .searchable(text: $searchText, placement: .toolbar)
                .overlay ( overlayButtonView )
        }
    }
    
    // MARK: - Action functions
    
    func goBack() {
        print("Navigates back")
    }
    
    func addPerson() {
        let newPerson = Person(name: "", email: "", notes: "")
        modelContext.insert(newPerson)
        path.append(newPerson)
    }
    
    func addRandomPerson() {
        for _ in 1...2 {
            let newPerson = Person.generateRandomPerson()
            modelContext.insert(newPerson)
        }
    }
 
    // MARK: - Subviews
    
    var overlayButtonView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    if StaticTestVars.isTesting {
                        Button(action: addRandomPerson) {
                            Image(systemName: "plus.circle")
                                .font(.largeTitle)
                                .padding()
                                .background(Circle().fill(Color.blue))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                    }
                    Button(action: addPerson) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .padding()
                            .background(Circle().fill(Color.blue))
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }
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
