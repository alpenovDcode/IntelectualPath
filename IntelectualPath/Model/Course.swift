//
//  Course.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import Foundation
import Firebase

struct Course: Identifiable, Codable {
    var id: String
    var title: String
    var category: String
    var lessonCount: Int
    var duration: String
    var instructor: String
    var filesCount: Int
    var description: String?
    
    init(id: String = UUID().uuidString, title: String, category: String, lessonCount: Int, duration: String, instructor: String, filesCount: Int, description: String?) {
            self.id = id
            self.title = title
            self.category = category
            self.lessonCount = lessonCount
            self.duration = duration
            self.instructor = instructor
            self.filesCount = filesCount
            self.description = description
        }
}
