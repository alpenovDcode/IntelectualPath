//
//  ProfileInfoSectionView.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct ProfileInfoSectionView: View {
    @Binding var isEditProfileViewVisible: Bool

    var body: some View {
        Section("Profile info") {
            Button {
                isEditProfileViewVisible.toggle()
            } label: {
                SettingsRawView(imageName: "pencil",
                                title: "Edit profile",
                                tintColor: .gray)
            }
        }
    }
}
