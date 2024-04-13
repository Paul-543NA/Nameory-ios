//
//  MemorySwipeView.swift
//  Nameory
//
//  Created by Paul Festor on 01/04/2024.
//

import SwiftUI
import SwiftData

struct MemorySwipeView: View {
    @Query(filter: Person.notRememberedTodayPredicate(),
             sort: \Person.lastRemembered
    ) var people: [Person]
    
    var body: some View {
        ZStack {
            ForEach(people) { person in
                PersonCardView(person: person)
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return MemorySwipeView().modelContainer(previewer.container)
    } catch {
        return Text("Failed to generate preview with error \(error.localizedDescription)")
    }
}
