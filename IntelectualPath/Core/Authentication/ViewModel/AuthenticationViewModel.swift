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
    
    func checkIfNewUser() async -> Bool {
            // Проверяем, есть ли текущий пользователь
            guard let currentUser = Auth.auth().currentUser else {
                // Если текущий пользователь отсутствует, считаем, что это новый пользователь
                return true
            }
            
            // Получаем UID текущего пользователя
            let uid = currentUser.uid
            
            // Пытаемся получить информацию о пользователе из Firestore
            do {
                let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
                if documentSnapshot.exists {
                    // Если документ пользователя существует, это не новый пользователь
                    return false
                } else {
                    // Если документ пользователя не существует, считаем, что это новый пользователь
                    return true
                }
            } catch {
                return true // При возникновении ошибки также считаем пользователя новым
            }
        }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            let result = try await Auth.auth().signIn(with: credential)
            self.userSession = result.user
            await fetchUser()
        } catch {
           //
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
                throw error
            }
        } catch {
            throw error
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
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
