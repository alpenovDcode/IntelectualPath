//
//  GeneralSectionView.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct GeneralSectionView: View {
    var body: some View {
        Section("General") {
            HStack {
                SettingsRawView(imageName: "gear",
                                title: "App Version",
                                tintColor: .gray)
                Spacer()

                Text("1.0.0")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
