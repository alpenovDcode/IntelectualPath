//
//  SearchBarView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct SearchBarView: View {
    @State private var searchText = ""

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search basic math, science..", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.leading, .trailing], 4)
        }
        .padding()
        .padding([.leading, .trailing], 18)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
    }
}
