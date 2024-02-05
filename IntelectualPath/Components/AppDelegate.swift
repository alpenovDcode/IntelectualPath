//
//  AppDelegate.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import Foundation

import Firebase
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }

}
