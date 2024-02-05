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
                VStack(spacing: 8){
                    Text("Welcome to IntellectualPath")
                        .font(.title)
                        .padding(.bottom, 10)
                        .foregroundColor(.black)
                    Text("Education is a passport to the future, for tomorrow belongs to those who prepare for it today.")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                }
                .padding([.leading, .trailing], 16)
                Spacer()
                VStack(spacing: 10) {
                    NavigationLink(destination: LoginView()) {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .padding()
                            .background(Capsule().fill(.blue))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: RegistrationView()) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .padding()
                            .background(Capsule().fill(.blue))
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .background(.white)
            
        }
    }
}

struct MainMenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .frame(width: 250)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(.blue)
            )
            .padding(.horizontal, 100)
    }
}

