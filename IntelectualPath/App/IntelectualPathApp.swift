//
//  IntelectualPathApp.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI
import Firebase

@main
struct IntelectualPathApp: App {
    
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        FirebaseApp.configure()
        setupAppCheck()
    }
    
    private func setupAppCheck() {
        Task {
            do {
                let token = try await AppCheck.appCheck().token(forcingRefresh: false)
                let tokenString = token.token

            } catch {
                //
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
