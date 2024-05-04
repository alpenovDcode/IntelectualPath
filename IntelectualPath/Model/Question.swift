//
//  Question.swift
//  IntelectualPath
//
//  Created by Альпеша on 02.05.2024.
//

import Foundation

struct Question: Identifiable {
    let id: UUID = UUID()
    let text: String
    let options: [String]
    let correctAnswer: Int
}
