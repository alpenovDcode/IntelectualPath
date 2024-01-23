//
//  LoginPattern.swift
//  IntelectualPath
//
//  Created by Альпеша on 18.01.2024.
//

import SwiftUI
import Foundation

struct PasswordPattern {
    var value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    func isValid() -> Bool {
        // Образец для проверки пароля: не менее 8 символов, минимум одна большая буква, одна цифра и один специальный символ
        let passwordPattern = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordPattern).evaluate(with: value)
    }
}
