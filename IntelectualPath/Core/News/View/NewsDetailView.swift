//
//  NewsDetailView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.05.2024.
//

import Foundation
import SwiftUI


struct NewsDetailView: View {
    var newsItem: NewsItem
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // User information vertically aligned and tight to the left
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 50, height: 50)
                            .padding(0) // Remove any default padding around the circle
                        
                        Text(authViewModel.currentUser?.fullName ?? "")
                            .font(.headline)
                            .padding(.leading, 8) // Ensure no leading padding
                        
                        Text(newsItem.topic)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.leading, 8)
                        
                        Text(formatDate(newsItem.date))
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    }
                }
                .padding(.leading, 8) // Ensure the VStack itself has no leading padding
                
                // Main text content of the news
                Text(newsItem.text)
                    .multilineTextAlignment(.center) // Center-align the text
                    .padding([.top, .horizontal]) // Apply padding to all sides except leading
            }
            .padding([.leading, .top, .bottom]) // Ensure no padding on the leading edge of the outermost VStack
        }
        .navigationTitle(newsItem.topic)    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm\ndd:MM:yy"
        return dateFormatter.string(from: date)
    }
}
