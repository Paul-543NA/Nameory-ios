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
    @Environment(\.scenePhase) var scenePhase
    @State private var isNotBackground: Bool = false
    
    var body: some View {
        Group {
            if showOnboardingView {
                OnboardingView()
            } else {
                if isNotBackground {
                    MemoryScreen()
                        .animation(.easeIn, value: isNotBackground)
                        .onChange(of: scenePhase) { oldValue, newValue in
                            if newValue == .background {
                                isNotBackground = false
                                print("Going to sleep")
                            }
                        }
                } else {
                    Color(uiColor: .systemBackground)
                        .ignoresSafeArea(edges: .all)
                        .onChange(of: scenePhase) { oldValue, newValue in
                            if newValue == .active {
                                withAnimation { isNotBackground = true }
                                print("Back in place")
                            }
                        }
                }
            }
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.5), value: showOnboardingView)
    }
}
