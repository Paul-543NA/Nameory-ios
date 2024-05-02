//
//  Person.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import Foundation
import SwiftData

typealias Person = NameorySchemaV1.Person

extension NameorySchemaV1 {
    @Model
    class Person {
        
        // MARK: Attributes
        
        var id: UUID
        var name: String
        var notes: String
        var metAt: Event?
        var avatar: Avatar?
        var dateMet: Date
        @Attribute(.externalStorage) var photoData: Data?
        
        var nextMemoryTestDate: Date
        var memoryIntervalIndex: Int = 0
        var nTestedToday: Int = 0

        static let memoryIntervals: [TimeInterval] = [
            0 * TimeInterval.secondsPerDay,                              // Zero days
            0 * TimeInterval.secondsPerDay,                              // Zero day
            2 * TimeInterval.secondsPerDay,                              // Two days
            3 * TimeInterval.secondsPerDay,                              // Three days
            TimeInterval.daysPerWeek * TimeInterval.secondsPerDay,       // One week
            3 * TimeInterval.daysPerWeek * TimeInterval.secondsPerDay,   // Three weeks
            TimeInterval.daysPerMonth * TimeInterval.secondsPerDay,      // One month (approximated as 30 days)
            3 * TimeInterval.daysPerMonth * TimeInterval.secondsPerDay,  // Three months (approximated as 90 days)
            TimeInterval.daysPerYear * TimeInterval.secondsPerDay        // One year (approximated as 365 days)
        ]
        
        // MARK: Initialisers and public methods
        
        init(name: String, notes: String, metAt: Event? = nil) {
            self.id = UUID()
            self.name = name
            self.notes = notes
            self.metAt = metAt
            self.dateMet = Date.now
            self.avatar = nil
            self.photoData = nil
            self.nextMemoryTestDate = Calendar.current.date(byAdding: DateComponents(day: -1), to: Date.now)!
        }
        
        func wasRemembered() {
            let todayStart = Calendar.current.date(bySettingHour: 00, minute: 1, second: 0, of: Date.now)!

            if nTestedToday == 0 {
                // Increase the memory interval index but do not exceed the maximum index.
                memoryIntervalIndex = min(memoryIntervalIndex + 1, Person.memoryIntervals.count - 1)
            } else {
                // Decrease the memory interval index to increase frequency of testing and reset testedToday flag.
                memoryIntervalIndex = max(memoryIntervalIndex - 1, 1)
                nTestedToday = 0
            }
            // Calculate the time interval until the next test based on the updated memory interval index.
            let intervalUntilNextTest = Person.memoryIntervals[memoryIntervalIndex]
            // Schedule the next memory test by adding the interval to the current next test date.
            nextMemoryTestDate = todayStart.addingTimeInterval(intervalUntilNextTest)
        }
        
        func wasNotRemembered() {
            nTestedToday += 1
        }
        
        // MARK: Query predicates
        
        static func notRememberedTodayPredicate() -> Predicate<Person> {
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
            let yesterdayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: yesterday)!

            return #Predicate<Person> { person in
                person.nextMemoryTestDate < yesterdayEnd
            }
        }
        
        // MARK: Test utilities
        
        static func generateRandomPerson() -> Person {
            let names = ["Alex Morgan", "Sam Taylor", "Chris Jordan", "Jordan Kim"]
            let notes = [
                "Alex enjoys hiking and has visited over 15 national parks in the past year.",
                "Sam is an avid reader and recently finished a novel on virtual reality.",
                "Chris is passionate about sustainable farming and volunteers on weekends at a local farm.",
                "Jordan is a freelance graphic designer who loves modern art and often visits galleries."
            ]
            let randomPerson = Person(
                name: names.randomElement()!,
                notes: notes.randomElement()!)
            
            randomPerson.avatar = Avatar(
                gender: [Gender.male, Gender.female].randomElement()!,
                skinTone: SkinTone.allCases.randomElement()!,
                hairColor: HairColor.allCases.randomElement()!)
            
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: Date.now)!
            randomPerson.dateMet = generateRandomDateSince(twoMonthsAgo)
            randomPerson.metAt = Event(name: "Climbing group", location: "Event location")
            randomPerson.nextMemoryTestDate = generateRandomDateSince(randomPerson.dateMet)
            
            return randomPerson
        }

        
    }
}


// Utilities to manage time intervals
extension TimeInterval {
    static let secondsPerDay: TimeInterval = 86_400
    static let daysPerWeek: TimeInterval = 7
    static let daysPerMonth: TimeInterval = 30 // Approximation
    static let daysPerYear: TimeInterval = 365 // Non-leap year
}
