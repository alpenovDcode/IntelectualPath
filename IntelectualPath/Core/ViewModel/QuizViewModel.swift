//
//  QuizViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedOptionIndex: Int? = nil
    @Published var score = 0
    @Published var isCorrect: Bool? = nil
    @Published var optionColor: Color = .primary
       
        
    
    func loadQuestions() {
        // Load questions from a data source (e.g., JSON file, API)
        questions = [
            Question(text: "What is the capital of France?", options: ["Paris", "London", "Berlin", "Madrid"], correctAnswer: 0),
            Question(text: "What is the largest planet in our solar system?", options: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: 2),
            // Add more questions as needed
        ]
    }
    
    func selectOption(_ index: Int) {
        selectedOptionIndex = index
        isCorrect = index == questions[currentQuestionIndex].correctAnswer
    }
    
    func submitAnswer() {
        if let selectedIndex = selectedOptionIndex {
            if questions[currentQuestionIndex].correctAnswer == selectedIndex {
                score += 1
            }
            isCorrect = nil
            selectedOptionIndex = nil
            currentQuestionIndex += 1
        }
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questions.count - 1
    }
}
