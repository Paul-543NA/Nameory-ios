//
//  PersonCardView.swift
//  Nameory
//
//  Created by Paul Festor on 28/03/2024.
//

import SwiftUI
import SwiftData

struct PersonCardView: View {
    @Bindable var person: Person
    @State var nameRevealed = false
    @State var swipex: CGFloat = 0
    @State var cardRotationAngle: Angle = .zero
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                // This VStack is used to vertically center the PersonImageView within the GeometryReader
                VStack {
                    PersonImageView(person: person, width: geometry.size.width, height: geometry.size.width, cornerRadius: 20)
                }
                // By default, GeometryReader takes up all available space, but here we use `.frame` to match the height to the width dynamically
                .frame(height: geometry.size.width)
            }
            // Limit GeometryReader's height to prevent it from taking up too much vertical space
            // This ensures the height is dynamically matched to the width
            .aspectRatio(1, contentMode: .fit)

            Text(nameRevealed ? person.name : "??????")
                .font(.title)
            Text("Net at \(person.metAt?.name ?? "N/A")")
                .font(.subheadline)
                .padding(.bottom)
            Text(person.notes == "" ? "No notes about this person" : person.notes)
            Spacer()
            HStack {
                Spacer()
                Text("Tap to reveal name")
                    .foregroundColor(.primary)
                    .opacity(nameRevealed ? 0 : 0.5)
                Spacer()
            }.padding(.horizontal)
        }
        .background(Color(UIColor.systemBackground))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(x: swipex)
        .rotationEffect(cardRotationAngle)
        .animation(.snappy, value: swipex)
        .animation(.snappy, value: cardRotationAngle)
        .gesture(
            DragGesture()
            .onChanged(onDragChanged)
            .onEnded(onDragEnded)
        )
        .onTapGesture { withAnimation { nameRevealed = true } }
    }
}

// Gesture handlers
extension PersonCardView {
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        if value.translation.width > 0.5*UIScreen.main.bounds.size.width {
            didRememberPerson()
        } else if value.translation.width < -0.5*UIScreen.main.bounds.size.width {
            didNotRememberPerson()
        } else {
            swipex = 0
            cardRotationAngle = .degrees(0)
        }
    }
    
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        swipex = value.translation.width
        cardRotationAngle = rotationAlgneFrom(xoffset: swipex)
    }
    
    func rotationAlgneFrom(xoffset: CGFloat) -> Angle {
        let normalisedx = 2 * xoffset / UIScreen.main.bounds.width
        return .degrees(normalisedx * 5)
    }
}

// Handles memory logic
extension PersonCardView {
    func didRememberPerson() {
        person.wasRemembered()
        swipex = 5 * UIScreen.main.bounds.width
    }
    
    func didNotRememberPerson() {
        person.wasNotRemembered()
        swipex = -5 * UIScreen.main.bounds.width
        swipex = 0
        cardRotationAngle = .zero
        nameRevealed = false
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Person.self, configurations: config)
    //        let previewer = BetterPReviewer()
        let person = Person(name: "John doe", notes: "Some notes")
        return PersonCardView(person: person)
    } catch {
        return Text("Failed to generate preview with error \(error.localizedDescription)")
    }
}
