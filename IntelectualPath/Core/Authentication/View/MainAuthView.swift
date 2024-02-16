//
//  MainMenuView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI
import Lottie

struct MainAuthView: View {
    @State var onboardingItems: [OnBoardingItem] = [
        .init(title: "IntelectualPath",
              subtitle: "Education is a passport to the future, for tomorrow belongs to those who prepare for it today.",
              lottieView: .init(name: "Hello", bundle: .main))
    ]
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                if let firstItem = onboardingItems.first {
                    ResizableLottie(onboardingItem: .constant(firstItem))
                        .frame(width: 300, height: 300)
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                }
                WelcomeTextView()
                Spacer()
                AuthButtons()
                Spacer()
            }
            .background(Color.white)
        }
    }
}
