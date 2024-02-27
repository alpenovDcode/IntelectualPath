//
//  User.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.01.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var fullName: String
    var email: String
//    var progress: Int
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
