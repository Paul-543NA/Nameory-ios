//
//  OnboardingView.swift
//  Nameory
//
//  Created by Paul Festor on 14/04/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("showOnboardingView") var showOnboardingView = true
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Welcome to Nameory!")
                        .font(.title)
                        .padding()
                    
                    Image("Onboarding_greeting")
                        .resizable()
                        .scaledToFit()
                    
                    Text("With this app, you will never forget people's names anymore! Add people you meet in here and learn their names over time thanks to the power of spaced repetition. Every day, you get to see a bunch of faces and remember their names. If you do, you will see them later in the future. If you don't, they will appear again sooner.")
                        .padding()
                }
            }
            
            // Button at the bottom of the screen
            Button("Get Started") {
                withAnimation {
                    showOnboardingView = false
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
