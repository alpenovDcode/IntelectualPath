//
//  RegistrationView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var registrationCompleted = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            CachedLogoImage()
                .frame(width: 100, height: 100)
                .padding(.vertical, 32)
            
            VStack(spacing: 16) {
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "example@example.com")
                    .autocorrectionDisabled()
                InputView(text: $fullName,
                          title: "Full Name",
                          placeholder: "Enter your name")
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        Image(systemName: password == confirmPassword ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(password == confirmPassword ? .green : .red)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    do {
                        try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                        
                        let deviceInfo = viewModel.getDeviceInfo()
                        
                        try await viewModel.saveDeviceInfo(deviceInfo)
                        
                        registrationCompleted = true
                        
                        viewModel.isLoggedIn = true
                    }
                }
            } label: {
                HStack {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }

            .background(Color(.systemBlue))
            .cornerRadius(10)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .padding(.top, 24)

            
            Spacer()
            
            HStack(spacing: 3) {
                Text("Already have an account?")
                Text("Sign In")
                    .fontWeight(.bold)
            }
            .font(.system(size: 14))
        }
    }
    
    var formIsValid: Bool {
        return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
            && confirmPassword == password
            && !fullName.isEmpty
    }
}
