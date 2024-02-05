//
//  ProgressCardView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct ProgressCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Where You Left")
                .font(.headline)
                .padding(.bottom, 1)
            HStack {
                VStack(alignment: .leading) {
                    Text("How to get started")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    ProgressView(value: 60, total: 100)
                        .accentColor(.blue)
                }
                Spacer()
                Text("60%")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}
