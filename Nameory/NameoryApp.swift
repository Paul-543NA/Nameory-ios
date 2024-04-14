//
//  NameoryApp.swift
//  Nameory
//
//  Created by Paul Festor on 17/03/2024.
//

import SwiftUI
import SwiftData

@main
struct NameoryApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: Person.self)
    }
}

struct RootView: View {
    @AppStorage("showOnboardingView") var showOnboardingView = true

    var body: some View {
        Group {
            if showOnboardingView {
                OnboardingView()
            } else {
                MemoryScreen()
            }
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.5), value: showOnboardingView)
    }
}
