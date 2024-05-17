//
//  CourseListViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 04.03.2024.
//

import SwiftUI
import FirebaseFirestore
import Combine
import FirebaseAuth

class CoursesListViewModel: ObservableObject {
    @Published var selectedCourses: [Course] = []
    @Published var courseInfos: [Course] = []

    func fetchSelectedCourses() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }

        let document = Firestore.firestore().collection("users").document(userID)
        document.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                print("Document does not exist")
                return
            }

            if let data = documentSnapshot.data(), let courseIDs = data["selectedCourses"] as? [String] {
                self.fetchCourses(withIDs: courseIDs)
            }
        }
    }
    func fetchCourseInfo(for courseID: String) {
            Firestore.firestore().collection("courseInfo").document(courseID).getDocument { documentSnapshot, error in
                if let error = error {
                    print("Error fetching course info: \(error.localizedDescription)")
                    return
                }

                if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                    guard let courseInfo = try? documentSnapshot.data(as: Course.self) else { return }
                    DispatchQueue.main.async {
                        self.courseInfos.append(courseInfo)
                    }
                }
            }
        }

    private func fetchCourses(withIDs courseIDs: [String]) {
        let group = DispatchGroup()

        for courseID in courseIDs {
            group.enter()
            Firestore.firestore().collection("courses").document(courseID).getDocument { documentSnapshot, error in
                defer { group.leave() }
                if let error = error {
                    print("Error fetching course with ID \(courseID): \(error.localizedDescription)")
                    return
                }

                if let documentSnapshot = documentSnapshot, documentSnapshot.exists, let course = try? documentSnapshot.data(as: Course.self) {
                    self.selectedCourses.append(course)
                }
            }
        }

        group.notify(queue: .main) {
            
        }
    }
}
