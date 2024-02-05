//
//  RecommendedCoursesView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct RecommendedCourseRow: View {
    let viewModel: RecommendedCourseRowViewModel

        init(course: Course) {
            self.viewModel = RecommendedCourseRowViewModel(course: course)
        }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 120)
                    .overlay(
                        Image(systemName: "play.circle.fill") // Play button
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.blue)
                    )
            }
            
            VStack(alignment: .leading) {
                Text(viewModel.course.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("By \(viewModel.course.instructor)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    // Files count
                    Image(systemName: "doc.fill")
                        .foregroundColor(.secondary)
                    Text("\(viewModel.course.filesCount) Files")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer(minLength: 0)
                    
                    // Course duration
                    Image(systemName: "clock.fill")
                        .foregroundColor(.secondary)
                    Text(viewModel.course.duration)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding([.leading, .trailing, .bottom], 8)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .frame(width: 180, height: 240)
    }
}

struct RecommendedView: View {
    var courses: [Course]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended for you")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(courses) { course in
                        RecommendedCourseRow(course: course)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RecommendedCoursesView: View {
    let viewModel = RecommendedCoursesViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended for you")
                .font(.headline)
                .padding(.vertical, 2)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.courses) { course in
                        RecommendedCourseRow(course: course)
                    }
                }
            }
        }
    }
}
