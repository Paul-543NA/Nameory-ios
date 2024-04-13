//
//  MemoryScreen.swift
//  Nameory
//
//  Created by Paul Festor on 13/04/2024.
//

import SwiftUI

struct MemoryScreen: View {
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Welcome to MemoryView")
                    .padding()
                Button("Go to ContentView") {
                    // Push ContentView onto the navigation stack
                    navigationPath.append("PeopleListScreen")
                }
            }
            .navigationTitle("MemoryView")
            .navigationDestination(for: String.self) { str in
                if str == "PeopleListScreen" {
                    PeopleListScreen(path: $navigationPath)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("This is ContentView")
            .navigationTitle("ContentView")
            .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    MemoryScreen()
//}
