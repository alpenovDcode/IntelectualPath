// AuthenticationViewModel.swift

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine
import UIKit

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoggedIn = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
        
        $userSession
            .map { $0 != nil }
            .assign(to: &$isAuthenticated)
    }
    
    
    func checkIfNewUser() async -> Bool {
        guard let currentUser = Auth.auth().currentUser else {
            return true
        }
        let uid = currentUser.uid
        do {
            let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            if documentSnapshot.exists {
                return false
            } else {
                return true
            }
        } catch {
            return true
        }
    }
    
    func checkIfAuthenticated() async -> Bool {
        return userSession != nil
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            let result = try await Auth.auth().signIn(with: credential)
            self.userSession = result.user
            await fetchUser()
            self.isAuthenticated = await checkIfAuthenticated()
            self.isLoggedIn = true
            didSignInSuccess()
        }
    }
    
    func getDeviceInfo() -> [String: Any] {
        let device = UIDevice.current
        let systemVersion = device.systemVersion
        let modelName = device.model
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let deviceID = device.identifierForVendor?.uuidString ?? ""
        
        let deviceInfo: [String: Any] = [
            "id": deviceID,
            "model": modelName,
            "os": systemVersion,
            "appVersion": appVersion
        ]
        return deviceInfo
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            let deviceInfo = getDeviceInfo()
            
            do {
                let encodedUser = try Firestore.Encoder().encode(user)
                var userData = encodedUser
                userData["deviceInfo"] = deviceInfo
                try await Firestore.firestore().collection("users").document(user.id).setData(userData)
                
                await fetchUser()
                didRegistrationSuccess()
            } catch {
                throw error
            }
        } catch {
            throw error
        }
    }

    func updateProgress(forUserWithID userID: String, newProgress: Double) async throws {
        do {
            try await Firestore.firestore().collection("users").document(userID).updateData(["progress": newProgress])
        } catch {
            throw error
        }
    }

    func registerUser() async throws -> Bool {
        do {
            try await createUser(withEmail: "example@example.com", password: "password", fullName: "John Doe")
            return true
        } catch {
            return false
        }
    }
    
    func didSignInSuccess() {
        isLoggedIn = true
        NotificationCenter.default.post(name: Notification.Name("UserDidSignIn"), object: nil)
    }
    
    func didRegistrationSuccess() {
        isLoggedIn = true
        NotificationCenter.default.post(name: Notification.Name("UserDidRegister"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("UserDidSignIn"), object: nil)
    }
    
    func saveDeviceInfo(_ deviceInfo: [String: Any]) async throws {
        do {
            try await Firestore.firestore().collection("deviceInfo").document(deviceInfo["id"] as! String).setData(deviceInfo)
        } catch {
            throw error
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            self.isAuthenticated = false
        } catch {
            //
        }
    }
    
    func deleteUser() async {
        do {
            guard let user = Auth.auth().currentUser else {
                return
            }
            
            let uid = user.uid
            let userDocRef = Firestore.firestore().collection("users").document(uid)
            try await userDocRef.delete()
            self.userSession = nil
            self.currentUser = nil
            self.isAuthenticated = false
        } catch {
            //
        }
    }
    
    func editUser(newFullName: String, newEmail: String) async throws {
        do {
            guard let user = Auth.auth().currentUser else {
                return
            }
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = newFullName
            try await changeRequest.commitChanges()
            if var updatedUser = self.currentUser {
                updatedUser.fullName = newFullName
                updatedUser.email = newEmail
                let encodedUser = try Firestore.Encoder().encode(updatedUser)
                try await Firestore.firestore().collection("users").document(user.uid).setData(encodedUser, merge: true)
                self.currentUser = updatedUser
            }
        } catch {
            throw error
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        do {
            let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try documentSnapshot.data(as: User.self)
        } catch {
            //
        }
    }
}
