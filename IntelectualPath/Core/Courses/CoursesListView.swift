//
//  CoursesListView.swift
//  IntelectualPath
//
//  Created by Альпеша on 01.03.2024.
//

import SwiftUI


struct CoursesListView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        List(authViewModel.selectedCourses) { course in
            NavigationLink(destination: CourseDetailView(course: course)) {
                Text(course.title)
            }
        }
        .navigationBarTitle("Selected Courses", displayMode: .inline)
    }
}





struct CourseDetailView: View {
    var course: Course

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(course.title).font(.title)
                Text("Instructor: \(course.instructor)").font(.subheadline)
                Text("Duration: \(course.duration)").font(.subheadline)
                Text("Files: \(course.filesCount)").font(.subheadline)
                if let description = course.description, !description.isEmpty {
                    Text(description).font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
