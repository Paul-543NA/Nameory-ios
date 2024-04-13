//
//  GlobalTestVars.swift
//  Nameory
//
//  Created by Paul Festor on 13/04/2024.
//

import Foundation

struct StaticTestVars {
    static var isTesting = true
}

extension Person {
    static func generateRandomPerson() -> Person {
        let names = ["Alex Morgan", "Sam Taylor", "Chris Jordan", "Jordan Kim"]
        let emails = ["alex.morgan@email.com", "sam.taylor@email.com", "chris.jordan@email.com", "jordan.kim@email.com"]
        let notes = [
            "Alex enjoys hiking and has visited over 15 national parks in the past year.",
            "Sam is an avid reader and recently finished a novel on virtual reality.",
            "Chris is passionate about sustainable farming and volunteers on weekends at a local farm.",
            "Jordan is a freelance graphic designer who loves modern art and often visits galleries."
        ]
        let randomPerson = Person(
            name: names.randomElement()!,
            email: emails.randomElement()!,
            notes: notes.randomElement()!)
        
        randomPerson.avatar = Avatar(
            gender: [Gender.male, Gender.female].randomElement()!,
            skinTone: SkinTone.allCases.randomElement()!,
            hairColor: HairColor.allCases.randomElement()!)
        
        let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: Date.now)!
        randomPerson.dateMet = generateRandomDateSince(twoMonthsAgo)
        randomPerson.metAt = Event(name: "Climbing group", location: "Event location")
        randomPerson.lastRemembered = generateRandomDateSince(randomPerson.dateMet)
        
        return randomPerson
    }
}

fileprivate func generateRandomDateSince(_ startData: Date) -> Date {
    let randomTimeInterval = Double.random(in: startData.timeIntervalSinceNow...0)
    return Date(timeIntervalSinceNow: randomTimeInterval)
}
