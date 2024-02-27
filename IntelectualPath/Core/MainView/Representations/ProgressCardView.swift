//
//  ProgressCardView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

//struct ProgressCardView: View {
//    
//    let user: User?
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Where You Left")
//                .font(.headline)
//                .padding(.bottom, 1)
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("How to get started")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    if let user = user {
//                        ProgressView(value: Double(user.progress) / 100.0, total: 1.0)
//                            .accentColor(.blue)
//                    } else {
//                        ProgressView()
//                            .accentColor(.blue)
//                    }
//                }
//                Spacer()
//                if let user = user {
//                    Text("\(user.progress)%")
//                        .foregroundColor(.gray)
//                } else {
//                    Text("N/A")
//                        .foregroundColor(.gray)
//                }
//            }
//        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//    }
//}
