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
    
    var body: some View {
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
            
            Spacer()
        }
        .padding()
    }
}
