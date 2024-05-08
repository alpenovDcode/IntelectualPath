//
//  QuiestionView.swift
//  IntelectualPath
//
//  Created by Альпеша on 02.05.2024.
//

import Foundation
import SwiftUI

// MARK: - QuestionView
struct QuestionView: View {
    let question: Question
    @Binding var selectedOptionIndex: Int?
    @State private var answerSubmitted: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(question.text)
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 5)
                )
            
            ForEach(question.options.indices, id: \.self) { index in
                Button(action: {
                    selectedOptionIndex = index
                    answerSubmitted = true // Set to true when an option is selected
                    
                }) {
                    OptionView(text: question.options[index], isSelected: selectedOptionIndex == index, isCorrect: answerSubmitted ? (selectedOptionIndex == question.correctAnswer) : nil)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)

                }
            }
        }
        .padding()
    }
}

struct OptionView: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool? // This will be nil until an answer is submitted

    var body: some View {
        Text(text)
            .font(.body)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(isSelected ? .white : .primary)
            .background(.gray.opacity(0.3))
            .cornerRadius(10)
            .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 5)
    }

}
