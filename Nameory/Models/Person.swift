//
//  Person.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import Foundation
import SwiftData

@Model
class Person {
    var id: UUID
    var name: String
    var email: String
    var notes: String
    var metAt: Event?
    var avatar: Avatar?
    var dateMet: Date
    var lastRemembered: Date
    @Attribute(.externalStorage) var photoData: Data?
    
    init(name: String, email: String, notes: String, metAt: Event? = nil) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.notes = notes
        self.metAt = metAt
        self.dateMet = Date.now
        self.avatar = nil
        self.photoData = nil
        self.lastRemembered = Date.distantPast
    }
    
}

// SwiftData @Query predicates
extension Person {
    static func notRememberedTodayPredicate() -> Predicate<Person> {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
        let yesterdayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: yesterday)!

        return #Predicate<Person> { person in
            person.lastRemembered < yesterdayEnd
        }
    }
}
