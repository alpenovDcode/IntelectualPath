//
//  MockAppCheckProviderFactory.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.02.2024.
//

import FirebaseAppCheck
import FirebaseAuth
import Combine
import FirebaseCore

func setupAppCheckProvider() {
    class MockAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
        func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
            return MockAppCheckProvider()
        }
    }

    class MockAppCheckProvider: NSObject, AppCheckProvider {
        func getToken(completion: @escaping (AppCheckToken?, Error?) -> Void) {
            // Implementation for retrieving a mock token
            let mockToken = AppCheckToken(token: "mockToken", expirationDate: Date(timeIntervalSinceNow: 3600))
            completion(mockToken, nil)
        }
    }

    // Use our AppCheck provider factory in debug mode
    let mockProviderFactory = MockAppCheckProviderFactory()
    AppCheck.setAppCheckProviderFactory(mockProviderFactory)
}

struct AppCheckSetup {
    static func setup() {
        setupAppCheckProvider()
    }
}
