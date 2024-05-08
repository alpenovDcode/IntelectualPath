//
//  RecommendedCoursesView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI
import FirebaseFirestore


struct RecommendedCourseRow: View {
    let course: Course
    @Binding var selectedCourses: [Course]
    @Binding var showErrorMessage: Bool
    @Binding var showSuccessMessage: Bool
    @Binding var messageText: String

    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 120)
                    .overlay(
                        Button(action: {
                            Task {
                                await handleCourseAddition(course)
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.blue)
                        }, alignment: .bottomTrailing
                    )

            // No need for ToastView here anymore
            }
            .padding([.leading, .trailing, .bottom], 8)

            Text(course.title)
                .font(.headline)
                .lineLimit(1)

            Text("By \(course.instructor)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Image(systemName: "doc.fill")
                    .foregroundColor(.secondary)
                Text("\(course.filesCount) Files")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer(minLength: 0)

                Image(systemName: "clock.fill")
                    .foregroundColor(.secondary)
                Text(course.duration)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .frame(width: 180, height: 240)
    }

    func handleCourseAddition(_ course: Course) async {
        if await authViewModel.checkIfAuthenticated() {
            addCourseToCurrentUser(course)
        } else {
            messageText = "Требуется авторизация для добавления курса."
            showErrorMessage = true
        }
    }

    func addCourseToCurrentUser(_ course: Course) {
        Task {
            do {
                try await authViewModel.addCourseToCurrentUser(course: course)
                selectedCourses.append(course)
                messageText = course.title
                showSuccessMessage = true
            } catch {
                messageText = "Ошибка при добавлении курса: \(error.localizedDescription)"
                showErrorMessage = true
            }
        }
    }
}


struct RecommendedCoursesView: View {
    @ObservedObject var viewModel: RecommendedCoursesViewModel
    @Binding var selectedCourses: [Course]
    @Binding var showErrorMessage: Bool
    @Binding var showSuccessMessage: Bool
    @Binding var messageText: String
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended for you")
                .font(.headline)
                .padding(.vertical, 2)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.courses, id: \.id) { course in
                        RecommendedCourseRow(course: course, selectedCourses: $selectedCourses, showErrorMessage: $showErrorMessage, showSuccessMessage: $showSuccessMessage, messageText: $messageText)
                            .environmentObject(authViewModel)
                    }
                }
            }
        }
    }
}

