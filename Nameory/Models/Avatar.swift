//
//  Avatar.swift
//  Nameory
//
//  Created by Paul Festor on 21/03/2024.
//

import Foundation
import SwiftUI
import SwiftData

typealias Avatar = NameorySchemaV1.Avatar

extension NameorySchemaV1 {
    @Model
    class Avatar {
        var gender: Gender
        var skinTone: SkinTone
        var hairColor: HairColor
        
        init(gender: Gender, skinTone: SkinTone, hairColor: HairColor) {
            self.gender = gender
            self.skinTone = skinTone
            self.hairColor = hairColor
        }
        
        static func defaultAvatar() -> Avatar {
            return Avatar(gender: .female, skinTone: .regular1, hairColor: .regular1)
        }
    }
}

enum Gender: Codable {
    case male, female
}

enum SkinTone: Codable, ColorRepresentable {
    var id: Self { self }
    case regular1, regular2, regular3, regular4, regular5, regular6, regular7, regular0, regular9, regular10
    case vivid1, vivid2, vivid3, vivid4, vivid5, vivid6, vivid7
        
    var color: Color {
        switch self {
            case .regular1: return Color(red: 64/255, green: 46/255, blue: 35/255)
            case .regular2: return Color(red: 97/255, green: 65/255, blue: 46/255)
            case .regular3: return Color(red: 115/255, green: 80/255, blue: 54/255)
            case .regular4: return Color(red: 145/255, green: 100/255, blue: 64/255)
            case .regular5: return Color(red: 181/255, green: 128/255, blue: 91/255)
            case .regular6: return Color(red: 216/255, green: 162/255, blue: 125/255)
            case .regular7: return Color(red: 237/255, green: 184/255, blue: 147/255)
            case .regular0: return Color(red: 245/255, green: 202/255, blue: 168/255)
            case .regular9: return Color(red: 246/255, green: 211/255, blue: 181/255)
            case .regular10: return Color(red: 174/255, green: 174/255, blue: 171/255)
            case .vivid1: return Color(red: 211/255, green: 50/255, blue: 20/255)
            case .vivid2: return Color(red: 240/255, green: 130/255, blue: 0/255)
            case .vivid3: return Color(red: 251/255, green: 206/255, blue: 55/255)
            case .vivid4: return Color(red: 112/255, green: 187/255, blue: 36/255)
            case .vivid5: return Color(red: 83/255, green: 151/255, blue: 250/255)
            case .vivid6: return Color(red: 148/255, green: 114/255, blue: 238/255)
            case .vivid7: return Color(red: 235/255, green: 108/255, blue: 184/255)
        }
    }
}

enum HairColor: Codable, ColorRepresentable {
    var id: Self { self }
    case regular1, regular2, regular3, regular4, regular5, regular6, regular7, regular8
    case vivid1, vivid2, vivid3, vivid4, vivid5, vivid6, vivid7
    
    var color: Color {
        switch self {
            case .regular1: return Color(red: 45/255, green: 42/255, blue: 40/255)
            case .regular2: return Color(red: 81/255, green: 59/255, blue: 47/255)
            case .regular3: return Color(red: 120/255, green: 74/255, blue: 32/255)
            case .regular4: return Color(red: 142/255, green: 64/255, blue: 36/255)
            case .regular5: return Color(red: 214/255, green: 119/255, blue: 8/255)
            case .regular6: return Color(red: 227/255, green: 119/255, blue: 134/255)
            case .regular7: return Color(red: 252/255, green: 222/255, blue: 142/255)
            case .regular8: return Color.black.opacity(1)
            case .vivid1: return Color(red: 211/255, green: 50/255, blue: 20/255)
            case .vivid2: return Color(red: 240/255, green: 130/255, blue: 0/255)
            case .vivid3: return Color(red: 251/255, green: 206/255, blue: 55/255)
            case .vivid4: return Color(red: 83/255, green: 151/255, blue: 250/255)
            case .vivid5: return Color(red: 148/255, green: 114/255, blue: 238/255)
            case .vivid6: return Color(red: 148/255, green: 114/255, blue: 238/255)
            case .vivid7: return Color(red: 235/255, green: 108/255, blue: 164/255)
        }
    }
}

