//
//  ProfileView.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.01.2024.
//

import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var isEditProfileViewVisible = false
    @State private var isAccountDeleted = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            // Проверяем, есть ли информация о пользователе
            if let user = viewModel.currentUser {
                userProfileContent(user: user)
            } else {
                notAuthenticatedView()
            }
        }
        .navigationTitle("Profile")  // Заголовок для всего представления
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                // Пытаемся загрузить данные пользователя, если это необходимо
                await viewModel.fetchUserIfNeeded()
            }
        }
        .onChange(of: viewModel.currentUser) { newUser, _ in
            if newUser != nil {
                // Additional logic if needed when user changes
            }
        }

    }

    @ViewBuilder
    private func userProfileContent(user: User) -> some View {
        List {
            UserProfileSectionView(user: user)
            GeneralSectionView()
            ProfileInfoSectionView(isEditProfileViewVisible: $isEditProfileViewVisible)
                .sheet(isPresented: $isEditProfileViewVisible) {
                    EditProfileView()
                }
            AccountSectionView(isAccountDeleted: $isAccountDeleted)
        }
    }

    @ViewBuilder
    private func notAuthenticatedView() -> some View {
        VStack {
            Text("Please Log in or Sign up")
                .padding()
            NavigationLink(destination: LoginView()) {
                Text("Sign In")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            NavigationLink(destination: RegistrationView()) {
                Text("Sign Up")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
