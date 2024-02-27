//
//  HeaderView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct HeaderView: View {
    let user: User?
    
    var body: some View {
        HStack {
            if let user = user {
                VStack(alignment: .leading) {
                    Text("Hello")
                        .foregroundColor(.gray)
                    Text(user.fullName)
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer()
                Image(systemName: "bell.fill")
                    .foregroundColor(.orange)
                    .imageScale(.large)
            }
        }
    }
}
