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
    @Attribute(.externalStorage) var photoData: Data?
    
    var nextMemoryTestDate: Date
    var memoryIntervalIndex: Int = 0
    var nTestedToday: Int = 0
    

    static let memoryIntervals: [TimeInterval] = [
        0 * TimeInterval.secondsPerDay,                              // Zero days
        1 * TimeInterval.secondsPerDay,                              // One day
        3 * TimeInterval.secondsPerDay,                              // Three days
        TimeInterval.daysPerWeek * TimeInterval.secondsPerDay,       // One week
        3 * TimeInterval.daysPerWeek * TimeInterval.secondsPerDay,   // Three weeks
        TimeInterval.daysPerMonth * TimeInterval.secondsPerDay,      // One month (approximated as 30 days)
        3 * TimeInterval.daysPerMonth * TimeInterval.secondsPerDay,  // Three months (approximated as 90 days)
        TimeInterval.daysPerYear * TimeInterval.secondsPerDay        // One year (approximated as 365 days)
    ]
    
    init(name: String, email: String, notes: String, metAt: Event? = nil) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.notes = notes
        self.metAt = metAt
        self.dateMet = Date.now
        self.avatar = nil
        self.photoData = nil
        self.nextMemoryTestDate = Date.now
    }
    
    func wasRemembered() {
        if nTestedToday == 0 {
            // Increase the memory interval index but do not exceed the maximum index.
            memoryIntervalIndex = min(memoryIntervalIndex + 1, Person.memoryIntervals.count - 1)
        } else {
            // Decrease the memory interval index to increase frequency of testing and reset testedToday flag.
            memoryIntervalIndex = max(memoryIntervalIndex - 1, 0)
            nTestedToday = 0
        }
        // Calculate the time interval until the next test based on the updated memory interval index.
        let intervalUntilNextTest = Person.memoryIntervals[memoryIntervalIndex]
        // Schedule the next memory test by adding the interval to the current next test date.
        nextMemoryTestDate = nextMemoryTestDate.addingTimeInterval(intervalUntilNextTest)
    }
    
    func wasNotRemembered() {
        nTestedToday += 1
    }
}

// SwiftData @Query predicates
extension Person {
    static func notRememberedTodayPredicate() -> Predicate<Person> {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
        let yesterdayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: yesterday)!

        return #Predicate<Person> { person in
            person.nextMemoryTestDate < yesterdayEnd
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
