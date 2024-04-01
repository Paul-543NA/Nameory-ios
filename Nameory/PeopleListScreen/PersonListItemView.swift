//
//  PersonListItemView.swift
//  Nameory
//
//  Created by Paul Festor on 18/03/2024.
//

import SwiftUI

struct PersonListItemView: View {
    var person: Person
    
    var body: some View {
        HStack {
            PersonImageView(person: person, width: 50, height: 50, cornerRadius: 5)
            VStack(alignment: .leading) {
                Text(person.name)
                Text(person.metAt?.name ?? "")
                    .font(.caption)
            }.padding(.leading, 5)
        }
    }
}

//#Preview {
//    PersonListItemView(person: Person(name: "John Doe", email: "john.doe@email.com", notes: "Something about john"))
//}
