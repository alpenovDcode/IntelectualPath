//
//  EditPrifleView.swift
//  IntelectualPath
//
//  Created by Альпеша on 24.01.2024.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State private var updatedFullName: String = ""
    @State private var updatedEmail: String = ""
    
    var body: some View {
        VStack {
            Text("Edit Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            Spacer()
            TextField("Full Name", text: $updatedFullName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            
            TextField("Email", text: $updatedEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            Spacer()
            Button(action: {
                Task {
                    do {
                        try await viewModel.editUser(newFullName: updatedFullName, newEmail: updatedEmail)
                    } catch {
                        // Обработка ошибок, если есть
                        print("DEBUG: Failed to edit user with error \(error.localizedDescription)")
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

            Spacer()
        }
        .padding()
    }
}
