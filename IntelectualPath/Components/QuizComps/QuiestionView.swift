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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Question Text
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
            
            // Options
            ForEach(question.options.indices, id: \.self) { index in
                Button(action: {
                    selectedOptionIndex = index
                }) {
                    OptionView(text: question.options[index], isSelected: selectedOptionIndex == index)
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
    
    var body: some View {
        HStack {

            Text(text)
                           .font(.body)
                           .padding()
                           .frame(maxWidth: .infinity)
                           .background(
                               RoundedRectangle(cornerRadius: 10)
                                   .fill(isSelected ? Color(.systemGray6) : Color.white)
                                   .shadow(color: Color(.systemGray4), radius: 5, x: 0, y: 5)
                           )
                   }
        }
    }

