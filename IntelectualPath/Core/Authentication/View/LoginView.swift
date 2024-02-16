//
//  LoginView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        NavigationStack {
            VStack {
                CachedLogoImage() // Используем кэшированное изображение
                    .frame(width: 200, height: 200)
                    .padding(.vertical, 32)
                    .clipShape(Circle())

                VStack(spacing: 16) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "example@example.com")
                        .autocorrectionDisabled()

                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)

                SignInButton(action: signInAction, isEnabled: formIsValid) // Вынесем кнопку в отдельный View

                Spacer()

                NavigationLink(destination: RegistrationView().navigationBarBackButtonHidden(true)) {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }

    var formIsValid: Bool {
        return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
    }

    func signInAction() {
        Task {
            do {
                try await viewModel.signIn(withEmail: email, password: password)
            } catch {
                // Handle any errors that might occur during sign-in
            }
        }
    }
}

struct SignInButton: View {
    let action: () -> Void
    let isEnabled: Bool

    var body: some View {
        Button(action: action) {
            HStack {
                Text("Sign In")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemBlue))
        .cornerRadius(10)
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.5)
        .padding(.top, 24)
    }
}
