//
//  NewsItem.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.05.2024.
//

import Foundation
import UIKit

struct NewsItem: Identifiable, Codable {
    var id: String
    var username: String
    var topic: String
    var text: String
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case id, username, topic, text, date
    }
    
    init(id: String, username: String, topic: String, text: String, date: Date) {
        self.id = id
        self.username = username
        self.topic = topic
        self.text = text
        self.date = date
    }
    
    // Конструктор, используемый для декодирования
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        topic = try container.decode(String.self, forKey: .topic)
        text = try container.decode(String.self, forKey: .text)
        date = try container.decode(Date.self, forKey: .date)
    }
    
    // Кодирование данных для сохранения
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encode(topic, forKey: .topic)
        try container.encode(text, forKey: .text)
        try container.encode(date, forKey: .date)
    }
}
