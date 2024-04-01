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
        self.container = try ModelContainer(for: Person.self, configurations: config)
        self.event = Event(name: "TEDxMinesNancy", location: "Nancy")
        self.avatar = Avatar(gender: .female, skinTone: .regular1, hairColor: .regular1)
        self.person = Person(name: "Dotan Negrin", email: "dotan@example.com", notes: "", metAt: self.event)
        self.person.metAt = event
        self.person.avatar = self.avatar
        
        container.mainContext.insert(person)
//        
//        let person2 = Person(name: "John Doe", email: "john.doe@hismail.com", notes: "Likes to play rugby, a true lad")
//        person2.avatar = Avatar(gender: .male, skinTone: .regular7, hairColor: .regular5)
//        person2.metAt = event
//        container.mainContext.insert(person2)
//        
//        let person3 = Person(name: "Jane Smith", email: "jane.smith@example.com", notes: "Vegan, loves nature and outdoor activities")
//        person3.avatar = Avatar(gender: .female, skinTone: .regular3, hairColor: .regular2)
//        person3.metAt = event
//        container.mainContext.insert(person3)
//
//        let person4 = Person(name: "Alex Johnson", email: "alex.j@example.net", notes: "Tech enthusiast, blogger")
//        person4.avatar = Avatar(gender: .female, skinTone: .vivid3, hairColor: .regular4)
//        person4.metAt = event
//        container.mainContext.insert(person4)
//
//        let person5 = Person(name: "Sam Rivera", email: "sam.r@example.org", notes: "Architect, interested in sustainable design")
//        person5.avatar = Avatar(gender: .male, skinTone: .regular6, hairColor: .regular3)
//        person5.metAt = event
//        container.mainContext.insert(person5)
    }
}
