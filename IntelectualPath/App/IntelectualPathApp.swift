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
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
