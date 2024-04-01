//
//  NameoryApp.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import SwiftUI
import SwiftData

@main
struct NameoryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
