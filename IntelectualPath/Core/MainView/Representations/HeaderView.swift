//
//  HeaderView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hello")
                    .foregroundColor(.gray)
                Text("Tarek Masud")
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
