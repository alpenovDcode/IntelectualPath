//
//  AuthButtons.swift
//  IntelectualPath
//
//  Created by Альпеша on 06.02.2024.
//

import SwiftUI

struct AuthButtons: View {
    
    var body: some View {
        VStack(spacing: 10) {
            NavigationLink(destination: LoginView()) {
                Text("Sign in")
                    .buttonStyle(MainMenuButtonStyle())
            }

            NavigationLink(destination: RegistrationView()) {
                Text("Sign Up")
                    .buttonStyle(MainMenuButtonStyle())
            }
        }
    }
}
