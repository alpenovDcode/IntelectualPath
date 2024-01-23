//
//  ContentView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}
