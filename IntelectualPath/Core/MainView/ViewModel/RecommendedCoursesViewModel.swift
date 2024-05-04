//
//  RecommendedCoursesViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI
import Combine

class RecommendedCoursesViewModel: ObservableObject {
    @Published var courses: [Course] = []

    init() {
        self.courses = [
            Course(title: "Python", category: "IT", lessonCount: 28, duration: "40 min", instructor: "Smith J.", filesCount: 17, description: "LearnPython"),
            Course(title: "C++", category: "IT", lessonCount: 28, duration: "40 min", instructor: "Smith J.", filesCount: 17, description: "LearnC++"),
            Course(title: "Swift", category: "IT", lessonCount: 15, duration: "180 min", instructor: "Ahtyamov R.B", filesCount: 25, description: "LearnSwift")
        ]
    }
}
