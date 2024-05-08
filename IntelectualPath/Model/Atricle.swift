//
//  Atricle.swift
//  IntelectualPath
//
//  Created by Альпеша on 08.05.2024.
//

import Foundation

struct Article: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var description: String
}

let sampleArticles = [
    Article(title: "Getting Started with SwiftUI", author: "Jane Doe", description: "Learn the basics of building interfaces with SwiftUI."),
    Article(title: "Advanced iOS Techniques", author: "John Appleseed", description: "Dive deeper into iOS development with advanced concepts."),
    Article(title: "Optimizing Your App", author: "Alice Johnson", description: "Techniques to make your app faster and more efficient."),
    Article(title: "Understanding Combine", author: "Emma Wilson", description: "Master reactive programming in Swift with Combine."),
    Article(title: "SwiftUI for Web Developers", author: "Chris Stone", description: "Explore how SwiftUI can be approached from a web development perspective."),
    Article(title: "Building Custom UI Components", author: "David Zhao", description: "Create custom reusable UI components in SwiftUI."),
    Article(title: "Data Persistence in SwiftUI", author: "Linda Young", description: "Learn about handling data storage in your SwiftUI apps.")
]
