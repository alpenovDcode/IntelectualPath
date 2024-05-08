//
//  UsefulArticlesView.swift
//  IntelectualPath
//
//  Created by Альпеша on 08.05.2024.
//

import Foundation
import SwiftUI


struct UsefulArticlesView: View {
    let articles: [Article]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Useful Articles")
                .font(.headline)
                .padding(.vertical)
            
            ForEach(articles) { article in
                VStack(alignment: .leading, spacing: 5) {
                    Text(article.title)
                        .font(.title3)
                        .bold()
                    Text("By \(article.author)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(article.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                .padding(8)
                .frame(width: 375, height: 150, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            }
        }
        .padding([.leading, .trailing], 8)
    }
}
//
//#Preview{
//    UsefulArticlesView(articles: [
//                Article(title: "Getting Started with SwiftUI", author: "Jane Doe", description: "Learn the basics of building interfaces with SwiftUI."),
//                Article(title: "Advanced iOS Techniques", author: "John Appleseed", description: "Dive deeper into iOS development with advanced concepts.")
//            ])
//            .padding()
//            .previewLayout(.sizeThatFits)
//}
