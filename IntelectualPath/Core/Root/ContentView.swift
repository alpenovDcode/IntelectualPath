//
//  ContentView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingWelcomeScreen = true
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        Group {
            if showingWelcomeScreen {
                WelcomeScreen()
            } else if let userSession = viewModel.userSession {
                if userSession.isAnonymous {
                    OnBoardingScreen()
                } else {
                    MainScreenView()
                }
            } else {
                OnBoardingScreen()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showingWelcomeScreen = false
            }
        }
    }
}

