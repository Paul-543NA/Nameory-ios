//
//  AddPersonButtonOverlay.swift
//  Nameory
//
//  Created by Paul Festor on 14/04/2024.
//

import SwiftUI

struct AddPersonButtonOverlay: View {
    
    @Environment(\.modelContext) var modelContext
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    if StaticTestVars.isTesting {
                        Button(action: addRandomPerson) {
                            Image(systemName: "plus.circle")
                                .font(.largeTitle)
                                .padding()
                                .background(Circle().fill(Color.blue))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                    }
                    Button(action: addPerson) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .padding()
                            .background(Circle().fill(Color.blue))
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }
                .padding(.bottom)
            }
        }
    }
    
    private func addRandomPerson() {
        for _ in 1...2 {
            let newPerson = Person.generateRandomPerson()
            modelContext.insert(newPerson)
        }
    }
    
    private func addPerson() {
        let newPerson = Person(name: "", notes: "")
        modelContext.insert(newPerson)
        path.append(newPerson)
    }
}

