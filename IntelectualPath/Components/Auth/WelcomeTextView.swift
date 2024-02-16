//
//  WelcomeTextView.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import Foundation
import SwiftUI

struct WelcomeTextView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Welcome to IntellectualPath")
                .font(.title)
                .padding(.bottom, 10)
                .foregroundColor(.black)
            Text("Education is a passport to the future, for tomorrow belongs to those who prepare for it today.")
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.vertical)
        }
        .padding([.leading, .trailing], 16)
    }
}
