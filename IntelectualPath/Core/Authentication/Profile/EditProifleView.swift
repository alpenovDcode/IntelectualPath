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
            EditProfileTitleView()
            Spacer()
            EditProfileTextField(title: "Full Name", text: $updatedFullName)
                .padding(.bottom, 10)
            Spacer()
            EditProfileSaveButton(viewModel: _viewModel, updatedFullName: $updatedFullName, updatedEmail: $updatedEmail)
        }
        .padding()
    }
}

#Preview {
    EditProfileView()
}
