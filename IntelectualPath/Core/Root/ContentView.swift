//
//  ContentView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingWelcomeScreen = true
    @State private var isNewUser = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        Group {
            if showingWelcomeScreen {
                WelcomeScreen()
                    .onAppear {
                        // Проверяем, является ли пользователь новым
                        Task {
                            isNewUser = await viewModel.checkIfNewUser()
                            showingWelcomeScreen = false
                        }
                    }
            } else {
                if isNewUser {
                    OnBoardingScreen()
                } else {
                    MainScreenView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // Проверяем, был ли пользователь ранее в приложении
                if UserDefaults.standard.bool(forKey: "hasSeenWelcomeScreen") {
                    self.showingWelcomeScreen = false
                    // Проверяем, новый ли пользователь
                    Task {
                        do {
                            self.isNewUser = try await viewModel.checkIfNewUser()
                        } catch {
                            //
                        }
                    }
                } else {
                    UserDefaults.standard.set(true, forKey: "hasSeenWelcomeScreen")
                    UserDefaults.standard.set(true, forKey: "isNewUser")
                }
            }
        }
    }
}
