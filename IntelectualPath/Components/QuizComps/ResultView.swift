//
//  ResultView.swift
//  IntelectualPath
//
//  Created by Альпеша on 02.05.2024.
//

import Foundation
import SwiftUI

struct ResultView: View {
    let score: Int
    let totalQuestions: Int
    let questions: [Question]  // Add this to pass the list of questions

    var body: some View {
        ScrollView {  // Use ScrollView to accommodate potentially long list of questions
            VStack(spacing: 16) {
                Text("Quiz Results")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Your score: \(score) out of \(totalQuestions)")
                    .font(.title2)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 5)
                    )

                // Displaying each question and the correct answer
                ForEach(questions) { question in
                    VStack(alignment: .leading) {
                        Text(question.text)
                            .fontWeight(.bold)
                            .padding([.top, .bottom], 5)

                        Text("Correct Answer: \(question.options[question.correctAnswer])")
                            .padding([.bottom], 5)
                            .foregroundColor(.green)  // Optional: make the text color green for clarity
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                            .shadow(radius: 1)
                    )
                }

                Spacer()
            }
            .padding()
        }
    }
}
