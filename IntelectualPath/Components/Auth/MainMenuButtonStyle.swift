//
//  MainMenuButtonStyle.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct MainMenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .frame(width: 250)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue)
            )
            .padding(.horizontal, 100)
    }
}
