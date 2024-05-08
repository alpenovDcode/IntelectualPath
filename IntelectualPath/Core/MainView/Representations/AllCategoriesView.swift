//
//  AllCategoriesView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct AllCategoriesView: View {
    let viewModel = AllCategoriesViewModel()
    @StateObject var recommendedCoursesViewModel = RecommendedCoursesViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("All Courses")
                .font(.headline)
                .padding(.vertical, 2)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        CategoryView(categoryName: category, viewModel: recommendedCoursesViewModel)
                    }
                }
            }
        }
    }
}

struct CategoryView: View {
    var categoryName: String
    @ObservedObject var viewModel: RecommendedCoursesViewModel

    var body: some View {
        Button(action: {
            viewModel.loadCourses(for: categoryName)
        }) {
            Text(categoryName)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
                .foregroundColor(.white)
        }
    }
}

