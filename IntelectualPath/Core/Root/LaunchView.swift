//
//  LaunchView.swift
//  IntelectualPath
//
//  Created by Альпеша on 23.02.2024.
//

import SwiftUI
import Combine

struct LaunchView: View {
    @StateObject var viewModel = LaunchViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if let navigationDestination = viewModel.navigationDestination {
                    switch navigationDestination {
                    case .welcomeScreen:
                        WelcomeScreen()
                            .task {
                                await viewModel.handleWelcomeScreen()
                            }
                    case .onboardingScreen:
                        OnBoardingScreen()
                    case .mainScreen:
                        MainScreenView()
                            .environmentObject(viewModel.viewModel)
                    case .mainAuthScreen:
                        MainAuthView()
                    }
                } else {
                    ProgressView()
                }
            }
            .task {
                await viewModel.handleOnAppear()
            }
        }
    }
}
