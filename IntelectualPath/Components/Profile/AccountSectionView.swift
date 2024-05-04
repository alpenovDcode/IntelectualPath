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
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Section("Account") {
            Button("Sign Out") {
                viewModel.signOut()
                presentationMode.wrappedValue.dismiss()
            }

            Button("Delete account") {
                Task {
                    await deleteAccount()
                }
            }
        }
    }

    private func deleteAccount() async {
        do {
            await viewModel.deleteUser()
            isAccountDeleted = true
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to delete user: \(error)")
        }
    }
}
