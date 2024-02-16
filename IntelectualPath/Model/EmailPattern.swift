//
//  EmailPattern.swift
//  IntelectualPath
//
//  Created by Альпеша on 18.01.2024.
//

import SwiftUI
import Foundation

struct EmailPattern {
    var address: String
    
    init(_ address: String) {
        self.address = address
    }
    
    func isValid() -> Bool {
        // Используем простой паттерн для проверки адреса электронной почты
        // Это представляет пример, реальная логика проверки будет более сложной
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: address)
    }
}
