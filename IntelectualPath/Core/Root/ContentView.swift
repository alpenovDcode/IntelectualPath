//
//  ContentView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingWelcomeScreen = true
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        Group {
            if showingWelcomeScreen {
                WelcomeScreen()
            } else {
                if viewModel.userSession != nil {
                    ProfileView()
                } else {
                    MainAuthView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showingWelcomeScreen = false
            }
        }
    }
}
