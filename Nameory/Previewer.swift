//
//  Previewer.swift
//  Nameory
//
//  Created by Paul Festor on 18/03/2024.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let avatar: Avatar
    let person: Person
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)

        self.container = try ModelContainer(for: Person.self, configurations: config)
        self.event = Event(name: "TEDxMinesNancy", location: "Nancy")
        self.avatar = Avatar(gender: .male, skinTone: .regular3, hairColor: .regular3)
        self.person = Person(name: "Alex Doe", notes: "", metAt: self.event)
        self.person.metAt = event
        self.person.avatar = self.avatar
        container.mainContext.insert(person)
    }
}
