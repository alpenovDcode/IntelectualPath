//
//  SplashScreenView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI

struct WelcomeScreen: View {
    
    
    @State private var isAppLoaded = false
    @State private var showOnBoarding = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                WelcomeContent(isAppLoaded: $isAppLoaded)
            }
            .opacity(isAppLoaded ? 0 : 1)
            .animation(.easeInOut(duration: 0.5), value: isAppLoaded)
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isAppLoaded = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showOnBoarding = true
                }
            }
        }
        .overlay(
            Group {
                if showOnBoarding {
                    OnBoardingScreen()
                }
            }
        )
    }
}

struct WelcomeContent: View {
    @Binding var isAppLoaded: Bool

    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("IntellectualPath")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
    }
}
