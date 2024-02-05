//
//  RecommendedCoursesViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct RecommendedCoursesViewModel {
    let courses: [Course] = [
        Course(title: "Biology for class XIII", category: "Biology", lessonCount: 28, duration: "40 Mints", instructor: "Smith J.", filesCount: 17),
        Course(title: "Math for class XIII", category: "Math", lessonCount: 28, duration: "40 Mints", instructor: "Smith J.", filesCount: 17)
    ]
}
