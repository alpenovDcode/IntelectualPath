//
//  AccountSectionView.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct AccountSectionView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Binding var isAccountDeleted: Bool
    @Binding var presentationMode: PresentationMode

    var body: some View {
        Section("Account") {
            Button {
                viewModel.signOut()
                presentationMode.dismiss()
            } label: {
                SettingsRawView(imageName: "arrow.left.circle.fill",
                                title: "Sign Out",
                                tintColor: .red)
            }

            Button {
                Task {
                    await deleteAccount()
                }
            } label: {
                SettingsRawView(imageName: "xmark.circle.fill",
                                title: "Delete account",
                                tintColor: .red)
            }
        }
    }

    private func deleteAccount() async {
        do {
            await viewModel.deleteUser()
            isAccountDeleted = true
        }
    }
}
