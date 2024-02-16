//
//  EditProfileSaveButton.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct EditProfileSaveButton: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Binding var updatedFullName: String
    @Binding var updatedEmail: String

    var body: some View {
        Button(action: {
            Task {
                do {
                    try await viewModel.editUser(newFullName: updatedFullName, newEmail: updatedEmail)
                } catch {
                    // 
                }
            }
        }) {
            Text("Save Changes")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal, 20)
    }
}
