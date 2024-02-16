//
//  UserProfileSectionView.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct UserProfileSectionView: View {
    let user: User

    var body: some View {
        Section {
            HStack {
                Text(user.initials)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 72, height: 72)
                    .background(.gray)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fullName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top, 4)

                    Text(user.email)
                        .font(.footnote)
                        .accentColor(.gray)
                }
            }
        }
    }
}
