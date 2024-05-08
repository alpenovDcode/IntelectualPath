//
//  CustomTabBar.swift
//  IntelectualPath
//
//  Created by Альпеша on 04.05.2024.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let isAuthenticated: Bool // Add a property to determine if the user is authenticated
    
    var body: some View {
        HStack {
            TabBarItem(icon: "house", title: "Home", selectedTab: $selectedTab, tag: 0)
            Spacer(minLength: 0)
            TabBarItem(icon: "book", title: "Learning", selectedTab: $selectedTab, tag: 1)
            Spacer(minLength: 0)
            TabBarItem(icon: "person", title: "Profile", selectedTab: $selectedTab, tag: 2)
            Spacer(minLength: 0)
            if isAuthenticated { // Conditionally include "Create News" tab item
                TabBarItem(icon: "square.and.pencil", title: "Create News", selectedTab: $selectedTab, tag: 3)
                Spacer(minLength: 0)
            }
            TabBarItem(icon: "newspaper", title: "News", selectedTab: $selectedTab, tag: isAuthenticated ? 4 : 3) // Adjust tag for News tab based on authentication status
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 30)
        .background(Color.white.clipShape(RoundedRectangle(cornerRadius: 30)))
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}


struct TabBarItem: View {
    var icon: String
    var title: String
    @Binding var selectedTab: Int
    var tag: Int

    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = tag
            }
        }) {
            VStack {
                Image(systemName: tag == selectedTab ? "\(icon).fill" : icon)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(tag == selectedTab ? .blue : .gray)
            .padding(.vertical, 8)
        }
    }
}
