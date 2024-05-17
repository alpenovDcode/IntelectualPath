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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }

            NavigationLink(destination: RegistrationView()) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
        }
        .padding()
    }
}

