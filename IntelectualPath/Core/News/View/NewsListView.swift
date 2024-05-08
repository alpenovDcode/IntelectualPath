//
//  NewsListView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.05.2024.
//

import Foundation
import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel: NewsViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.fixed(180)), GridItem(.fixed(180))], spacing: 20) {
                    ForEach(viewModel.newsItems) { item in
                        NavigationLink(destination: NewsDetailView(newsItem: item)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Circle()
                                        .frame(width: 30, height: 30, alignment: .center)
                                    VStack(alignment: .leading) {
                                        Text(authViewModel.currentUser?.fullName ?? "")
                                            .font(.headline)
                                        Text(item.topic)
                                            .font(.subheadline)
                                    }
                                }
                                Text(item.text)
                                    .lineLimit(3)
                                    .truncationMode(.tail)
                                    .font(.system(size: 14))
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                            .padding(8) // Padding around each news item
                            .frame(width: 160, height: 160) // Explicit width and height for each item
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("News Feed")
            .onAppear{
                viewModel.fetchNewsItems()
            }
        }
    }
}
