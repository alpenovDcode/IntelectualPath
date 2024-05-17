//
//  NewsViewModel.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.05.2024.
//

import Foundation
import Combine
import UIKit
import FirebaseFirestore
import Firebase
import FirebaseDatabaseInternal


extension NewsViewModel {
    // Fetch news items from Firestore
    func fetchNewsItems() {
        Firestore.firestore().collection("newsItems").order(by: "date", descending: true).getDocuments { (snapshot, error) in
            if let error = error {
                print("Ошибка получения документов: \(error)")
            } else {
                self.newsItems = snapshot?.documents.compactMap {
                    try? $0.data(as: NewsItem.self)
                } ?? []
            }
        }
    }
    
    
    // Add news item to Firestore
    func addNewsItemToFirestore(username: String, topic: String, text: String) {
        let newItem = NewsItem(id: UUID().uuidString, username: username, topic: topic, text: text, date: Date())
        do {
            try Firestore.firestore().collection("newsItems").document(newItem.id).setData(from: newItem)
            self.newsItems.insert(newItem, at: 0) // Добавляет новость в локальный массив для мгновенного обновления UI
        } catch let error {
            print("Ошибка при записи документа: \(error)")
        }
    }
    
}


class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    
    func addNewsItem(username: String, topic: String, text: String, image: UIImage?) {
        let newItem = NewsItem(id: UUID().uuidString, username: username, topic: topic, text: text, date: Date())
        newsItems.append(newItem)
    }
}

