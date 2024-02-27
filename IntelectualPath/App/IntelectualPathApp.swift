//
//  IntelectualPathApp.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI
import Firebase
import FirebaseAppCheck

@main
struct IntelectualPathApp: App {
    
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        FirebaseApp.configure()
        AppCheckSetup.setup()
    }

    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(viewModel)
        }
    }
}
