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
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 50, height: 50)
                            .padding(0)
                        
                        Text(authViewModel.currentUser?.fullName ?? "")
                            .font(.headline)
                            .padding(.leading, 8)
                        
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
                .padding(.leading, 8)
                Text(newsItem.text)
                    .multilineTextAlignment(.center)
                    .padding([.top, .horizontal])
            }
            .padding([.leading, .top, .bottom])
        }
        .navigationTitle(newsItem.topic)    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm\ndd:MM:yy"
        return dateFormatter.string(from: date)
    }
}
