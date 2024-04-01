//
//  Event.swift
//  Nameory
//
//  Created by Paul Festor on 18/03/2024.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String
    var location: String
    var prople = [Person]()
    
    init(name: String, location: String, prople: [Person] = [Person]()) {
        self.name = name
        self.location = location
        self.prople = prople
    }
}
