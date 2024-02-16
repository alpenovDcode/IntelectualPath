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
        if let user = viewModel.currentUser {
            List {
                UserProfileSectionView(user: user)
                
                GeneralSectionView()
                
                ProfileInfoSectionView(isEditProfileViewVisible: $isEditProfileViewVisible)
                    .sheet(isPresented: $isEditProfileViewVisible) {
                        EditProfileView()
                    }

                AccountSectionView(viewModel: _viewModel, isAccountDeleted: $isAccountDeleted, presentationMode: presentationMode)
            }
        }
    }
}
