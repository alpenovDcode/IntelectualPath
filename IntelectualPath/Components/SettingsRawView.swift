//
//  SettingsRawView.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.01.2024.
//

import SwiftUI

struct SettingsRawView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SettingsRawView(imageName: "gear", title: "Version", tintColor: .gray)
}
