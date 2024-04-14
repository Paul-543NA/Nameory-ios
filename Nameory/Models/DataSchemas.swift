//
//  DataSchemas.swift
//  Nameory
//
//  Created by Paul Festor on 14/04/2024.
//

import Foundation
import SwiftData

enum NameorySchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Person.self, Event.self, Avatar.self]
    }
}
