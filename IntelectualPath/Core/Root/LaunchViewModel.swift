//
//  LaunchViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.02.2024.
//

import SwiftUI
import Combine

class LaunchViewModel: ObservableObject {
    @Published var navigationDestination: NavigationDestination? = .welcomeScreen
    @ObservedObject var viewModel = AuthenticationViewModel()
    @Published var isLoggedIn: Bool = false
    
    enum NavigationDestination {
        case welcomeScreen
        case onboardingScreen
        case mainScreen
        case mainAuthScreen
    }
    private var signInNotification: AnyCancellable?
    private var registerNotification: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.signInNotification = NotificationCenter.default.publisher(for: Notification.Name("UserDidSignIn"))
            .sink { _ in
                self.handleSignIn()
            }
        self.registerNotification = NotificationCenter.default.publisher(for: Notification.Name("UserDidRegister"))
            .sink { _ in
                self.handleRegistration()
            }
        viewModel.$isLoggedIn
            .sink { [weak self] isLoggedIn in
                if isLoggedIn {
                    self?.navigationDestination = .mainScreen
                }
            }
            .store(in: &cancellables)
    }
    
    func handleSignIn() {
        viewModel.isLoggedIn = true
    }
    
    func handleRegistration() {
        self.navigationDestination = .mainScreen
    }
    
    func handleWelcomeScreen() async {
        navigationDestination = .welcomeScreen
    }
    
    func handleOnAppear() async {
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
        do {
            let isAuthenticated = await viewModel.checkIfAuthenticated()
            if isAuthenticated {
                viewModel.isLoggedIn = true
            } else {
                navigationDestination = .mainAuthScreen
            }
        }
    }
}
