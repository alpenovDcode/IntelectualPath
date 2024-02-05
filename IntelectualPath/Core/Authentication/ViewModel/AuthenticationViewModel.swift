//
//  AuthenticationViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 18.01.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            let result = try await Auth.auth().signIn(with: credential)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            do {
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
                await fetchUser()
            } catch {
                print("DEBUG: Failed to save user data to Firestore with error \(error.localizedDescription)")
                throw error
            }
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw error
        }
    }

    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
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
        } catch {
            print("DEBUG: Failed to delete user document with error \(error.localizedDescription)")
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
            print("DEBUG: Failed to edit user with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        do {
            let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try documentSnapshot.data(as: User.self)
        } catch {
            print("DEBUG: Failed to fetch user with error \(error.localizedDescription)")
        }
    }
}
