//
//  RecommendedCoursesViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import Combine

class RecommendedCoursesViewModel: ObservableObject {
    @Published var courses: [Course] = []
    
    init() {
            loadCourses(for: "Programming") // Load Programming courses by default
        }
    
    func loadCourses(for category: String) {
        switch category {
        case "Programming":
            courses = [
                Course(title: "Introduction to Python", category: "Programming", lessonCount: 10, duration: "30 min", instructor: "Alice Johnson", filesCount: 5, description: "Beginner-friendly Python course."),
                Course(title: "C++ Fundamentals", category: "Programming", lessonCount: 12, duration: "45 min", instructor: "Bob Smith", filesCount: 7, description: "Learn the basics of C++ programming."),
                Course(title: "Swift from Scratch", category: "Programming", lessonCount: 15, duration: "25 min", instructor: "Carol Taylor", filesCount: 9, description: "Develop iOS apps using Swift."),
                Course(title: "Java Essentials", category: "Programming", lessonCount: 8, duration: "35 min", instructor: "Dave Wilson", filesCount: 6, description: "Core concepts of Java programming."),
                Course(title: "JavaScript for Web Development", category: "Programming", lessonCount: 20, duration: "40 min", instructor: "Eve Martinez", filesCount: 12, description: "Interactive web pages with JavaScript.")
            ]
        case "General math":
            courses = [
                Course(title: "Algebra Basics", category: "General math", lessonCount: 10, duration: "40 min", instructor: "Fiona Chen", filesCount: 8, description: "Fundamentals of algebra."),
                Course(title: "Calculus I", category: "General math", lessonCount: 15, duration: "50 min", instructor: "George Davies", filesCount: 10, description: "Introduction to calculus."),
                Course(title: "Statistics 101", category: "General math", lessonCount: 12, duration: "45 min", instructor: "Hannah East", filesCount: 7, description: "Basics of statistical analysis."),
                Course(title: "Geometry Concepts", category: "General math", lessonCount: 8, duration: "30 min", instructor: "Ian Foster", filesCount: 5, description: "Understanding shapes and forms."),
                Course(title: "Trigonometry Introduction", category: "General math", lessonCount: 14, duration: "55 min", instructor: "Julia Grant", filesCount: 9, description: "Study of triangles.")
            ]
        case "Language":
            courses = [
                Course(title: "English for Beginners", category: "Language", lessonCount: 20, duration: "30 min", instructor: "Kevin Hart", filesCount: 10, description: "Start learning English."),
                Course(title: "Spanish Intermediate", category: "Language", lessonCount: 15, duration: "40 min", instructor: "Laura Young", filesCount: 12, description: "Improve your Spanish skills."),
                Course(title: "French Vocabulary", category: "Language", lessonCount: 10, duration: "35 min", instructor: "Mike Brown", filesCount: 6, description: "Expand your French vocabulary."),
                Course(title: "German Grammar", category: "Language", lessonCount: 12, duration: "45 min", instructor: "Nancy White", filesCount: 7, description: "Understand the basics of German grammar."),
                Course(title: "Italian Conversation", category: "Language", lessonCount: 18, duration: "50 min", instructor: "Olivia Lee", filesCount: 11, description: "Practice everyday Italian.")
            ]
        case "Biology":
            courses = [
                Course(title: "Cell Biology", category: "Biology", lessonCount: 12, duration: "35 min", instructor: "Patricia Scott", filesCount: 7, description: "Explore the microscopic world."),
                Course(title: "Genetics for Beginners", category: "Biology", lessonCount: 10, duration: "40 min", instructor: "Quinn Johnson", filesCount: 6, description: "Introduction to genetics."),
                Course(title: "Human Anatomy", category: "Biology", lessonCount: 15, duration: "45 min", instructor: "Rachel Kim", filesCount: 9, description: "Learn about human body structure."),
                Course(title: "Marine Biology", category: "Biology", lessonCount: 8, duration: "30 min", instructor: "Steve Lee", filesCount: 5, description: "Study life in the oceans."),
                Course(title: "Ecology Fundamentals", category: "Biology", lessonCount: 14, duration: "55 min", instructor: "Tina Brown", filesCount: 11, description: "Basics of ecological science.")
            ]
        default:
            courses = []
        }
    }
}

