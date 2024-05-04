//
//  QuizView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI


struct QuizView: View {
    @StateObject private var viewModel = QuizViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                if viewModel.currentQuestionIndex < viewModel.questions.count {
                    QuestionView(question: viewModel.questions[viewModel.currentQuestionIndex], selectedOptionIndex: $viewModel.selectedOptionIndex)
                } else {
                    ResultView(score: viewModel.score, totalQuestions: viewModel.questions.count)
                }
                
                Spacer()
                
                if viewModel.currentQuestionIndex < viewModel.questions.count {
                    Button(action: {
                        viewModel.submitAnswer()
                    }) {
                        Text("Submit")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: {
                        viewModel.loadQuestions()
                        viewModel.currentQuestionIndex = 0
                        viewModel.score = 0
                    }) {
                        Text("Restart")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadQuestions()
        }
    }
}
