//
//  User.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.01.2024.
//

import Foundation



struct User: Identifiable, Codable, Equatable {
    let id: String
    var fullName: String
    var email: String
    var selectedCourses: [String]?
    // var progress: Int

    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }

    init(id: String, fullName: String, email: String, selectedCourses: [String]? = nil) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.selectedCourses = selectedCourses
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        // Compare based on id only or add more conditions if necessary
        return lhs.id == rhs.id && lhs.fullName == rhs.fullName && lhs.email == rhs.email && lhs.selectedCourses == rhs.selectedCourses
    }
}
