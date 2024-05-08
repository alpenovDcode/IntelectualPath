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
    @Published var selectedCourses: [Course] = []
    private let userDefaults = UserDefaults.standard
    
    init() {
            initializeUser()
        }
        
        func initializeUser() {
            userSession = Auth.auth().currentUser
            loadUserFromUserDefaults()
            Task {
                await fetchUserIfNeeded()
                updateAuthenticationStatus()
            }
        }
        
        private func loadUserFromUserDefaults() {
            if let userData = userDefaults.data(forKey: "currentUser"), let user = try? JSONDecoder().decode(User.self, from: userData) {
                currentUser = user
                isLoggedIn = true
            }
        }
        
        private func saveUserToUserDefaults() {
            if let user = currentUser, let userData = try? JSONEncoder().encode(user) {
                userDefaults.set(userData, forKey: "currentUser")
            }
        }
        
        private func updateAuthenticationStatus() {
            isAuthenticated = userSession != nil
            isLoggedIn = userSession != nil && currentUser != nil
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
                userSession = result.user
                await fetchUserIfNeeded()
                saveUserToUserDefaults()
                updateAuthenticationStatus()
                didSignInSuccess()
            } catch {
                isLoggedIn = false
                isAuthenticated = false
                throw error
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
    
    func addCourseToCurrentUser(course: Course) async throws {
        guard let userID = self.userSession?.uid else {
            return
        }
        
        do {
            let courseDict: [String: Any] = [
                "title": course.title,
                "category": course.category,
                "lessonCount": course.lessonCount,
                "duration": course.duration,
                "instructor": course.instructor,
                "filesCount": course.filesCount,
                "description": course.description ?? ""
            ]
            
            let userDocRef = Firestore.firestore().collection("users").document(userID)
            try await userDocRef.updateData([
                "selectedCourses": FieldValue.arrayUnion([courseDict])
            ])
        } catch {
            throw error
        }
    }

    func fetchUserCourses() async {
        guard let userID = userSession?.uid else {
            print("No user ID available")
            return
        }
        
        let userDocRef = Firestore.firestore().collection("users").document(userID)
        do {
            let snapshot = try await userDocRef.getDocument()
            if let data = snapshot.data(), let coursesData = data["selectedCourses"] as? [[String: Any]] {
                let fetchedCourses: [Course] = coursesData.compactMap { dict in
                    guard let title = dict["title"] as? String,
                          let category = dict["category"] as? String,
                          let lessonCount = dict["lessonCount"] as? Int,
                          let duration = dict["duration"] as? String,
                          let instructor = dict["instructor"] as? String,
                          let filesCount = dict["filesCount"] as? Int,
                          let description = dict["description"] as? String else {
                              print("Error mapping course from Firestore: missing expected fields")
                              return nil
                          }
                    return Course(id: UUID().uuidString, title: title, category: category, lessonCount: lessonCount, duration: duration, instructor: instructor, filesCount: filesCount, description: description)
                }
                DispatchQueue.main.async {
                    self.selectedCourses = fetchedCourses
                    print("Courses successfully fetched and updated: \(self.selectedCourses.count) courses loaded.")
                }
            } else {
                print("No data found or data format incorrect for 'selectedCourses'")
            }
        } catch {
            print("Failed to fetch user courses: \(error.localizedDescription)")
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
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        NotificationCenter.default.post(name: Notification.Name("UserDidSignIn"), object: nil)
        Task {
            await fetchUserCourses()
        }
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
                userSession = nil
                currentUser = nil
                isAuthenticated = false
                isLoggedIn = false
                userDefaults.removeObject(forKey: "currentUser")
                userDefaults.removeObject(forKey: "isLoggedIn")
            } catch {
                print("Error signing out: \(error)")
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
            self.currentUser = try? documentSnapshot.data(as: User.self)
        } catch {
            print("Error fetching user data: \(error)")
        }
    }

    func fetchUserIfNeeded() async {
            guard let uid = userSession?.uid else { return }
            do {
                let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
                if let user = try? documentSnapshot.data(as: User.self) {
                    currentUser = user
                    saveUserToUserDefaults()
                }
                updateAuthenticationStatus()
            } catch {
                print("Error fetching user data: \(error)")
            }
        }
}
