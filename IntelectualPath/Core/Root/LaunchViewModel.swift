//
//  LaunchViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.02.2024.
//

import SwiftUI
import Combine
import Firebase
import FirebaseAuth

class LaunchViewModel: ObservableObject {
    @Published var navigationDestination: NavigationDestination? = .welcomeScreen
    @StateObject var viewModel = AuthenticationViewModel()
    @Published var isLoggedIn: Bool = false
    
    enum NavigationDestination {
        case welcomeScreen
        case onboardingScreen
        case mainScreen
        case mainAuthScreen
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Подписка на статус входа в систему от viewModel
        viewModel.$isLoggedIn
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoggedIn in
                self?.isLoggedIn = isLoggedIn
                self?.updateUIBasedOnAuthStatus()
            }
            .store(in: &cancellables)
    }
    
    private func updateUIBasedOnAuthStatus() {
        if isLoggedIn {
            navigationDestination = .mainScreen
        } else if UserDefaults.standard.bool(forKey: "hasSeenWelcomeScreen") {
            navigationDestination = .welcomeScreen
        } else {
            UserDefaults.standard.set(true, forKey: "hasSeenWelcomeScreen")
            navigationDestination = .onboardingScreen
        }
    }
    
    func handleOnAppear() async {
        // Инициализация пользователя и проверка его статуса
        viewModel.initializeUser()
        if UserDefaults.standard.bool(forKey: "hasSeenWelcomeScreen") {
            let isNewUser = await viewModel.checkIfNewUser()
            if isNewUser {
                navigationDestination = .onboardingScreen
            } else {
                await checkAuthentication()
            }
        } else {
            UserDefaults.standard.set(true, forKey: "hasSeenWelcomeScreen")
            UserDefaults.standard.set(true, forKey: "isNewUser")
            navigationDestination = .welcomeScreen
        }
    }
    
    private func checkAuthentication() async {
        let isAuthenticated = await viewModel.checkIfAuthenticated()
        if isAuthenticated {
            viewModel.isLoggedIn = true
        } else {
            navigationDestination = .mainAuthScreen
        }
    }
}
