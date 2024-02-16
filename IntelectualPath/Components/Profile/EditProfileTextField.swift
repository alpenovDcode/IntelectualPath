//
//  EditProfileTextField.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct EditProfileTextField: View {
    let title: String
    @Binding var text: String

    var body: some View {
        TextField(title, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 20)
    }
}
