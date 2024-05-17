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
        .task {
            await authViewModel.fetchUserIfNeeded()
            await authViewModel.fetchUserCourses()
        }

        .navigationBarTitle("Selected Courses", displayMode: .inline)
    }
}



struct CourseDetailView: View {
    var course: Course
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
//                Text(course.title).font(.title)
                Text("Instructor: \(course.instructor)").font(.subheadline)
                Text("Duration: \(course.duration)").font(.subheadline)
                Text("Files: \(course.filesCount)").font(.subheadline)
                if let description = course.description, !description.isEmpty {
                    Text(description).font(.body)
                }
                
                NavigationLink(destination: QuizView(topic: course.title)) {
                    Text("Пройти тест")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
        }

        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
