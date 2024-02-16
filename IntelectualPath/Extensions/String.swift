//
//  String.swift
//  IntelectualPath
//
//  Created by Альпеша on 20.01.2024.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailPattern = """
            ^[a-zA-Z0-9.!#$%&'*+/=?^_{|}~-]+
            @[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?
            (?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$
            """
        do {
            let regex = try NSRegularExpression(pattern: emailPattern, options: .caseInsensitive)
            return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
        } catch {
            // Handle the error here, e.g., log the error or return false
            return false
        }
    }
}
