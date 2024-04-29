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
        
        TabView {
            welcomeView.padding()
            OnboardingImagePageView(imageName: "Onboard profile", description: "When you want to remember a name, log their appearance, where you met, and a fact about them here")
            OnboardingImagePageView(imageName: "Onboard list", description: "The app will list them for you to search back")
            OnboardingImagePageView(imageName: "Onboard card", description: "Come every day to improve youe memory of names")
            OnboardingImagePageView(imageName: "Onboard swipe", description: "Swipe right if you remember, left if you don't, the app manages the rest!")
            doneOnboardingPage
       }
       .tabViewStyle(PageTabViewStyle())
       .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
    }
    
    private var welcomeView: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Welcome to Nameory!")
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    Image("Onboarding_greeting")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .padding(.horizontal, 30)
                    
                    Text("With this app, you will never forget people's names anymore! Add people you meet in here and learn their names over time thanks to the power of spaced repetition. Every day, you get to see a bunch of faces and remember their names. If you do, you will see them later in the future. If you don't, they will appear again sooner.")
                        .padding()
                }
            }
        }
    }
    
    private var doneOnboardingPage: some View {
        VStack {
            Spacer()
            // Button at the bottom of the screen
            Button("Get Started") {
                withAnimation {
                    showOnboardingView = false
                }
            }
            .padding()
            .padding(.horizontal)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(20)
            .padding(.horizontal)
            Spacer()

        }
    }
}

fileprivate struct OnboardingImagePageView: View {
    var imageName: String
    var description: String
    
    var body: some View {
        ScrollView {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .padding(.horizontal, 40)
                
                Text(description)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding()
        }
    }
}


#Preview {
    OnboardingView()
}
