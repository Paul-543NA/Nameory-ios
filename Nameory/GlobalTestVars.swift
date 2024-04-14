//
//  GlobalTestVars.swift
//  Nameory
//
//  Created by Paul Festor on 13/04/2024.
//

import Foundation

struct StaticTestVars {
    static var isTesting = false
}

func generateRandomDateSince(_ startData: Date) -> Date {
    let randomTimeInterval = Double.random(in: startData.timeIntervalSinceNow...0)
    return Date(timeIntervalSinceNow: randomTimeInterval)
}
