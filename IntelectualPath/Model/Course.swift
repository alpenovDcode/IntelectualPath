//
//  Course.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import Foundation

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var category: String
    var lessonCount: Int
    var duration: String
    var instructor: String
    var filesCount: Int
}
