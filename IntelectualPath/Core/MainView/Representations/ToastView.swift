//
//  ToastView.swift
//  IntelectualPath
//
//  Created by Альпеша on 04.05.2024.
//

import SwiftUI

struct ToastView: View {
    let text: String
    @Binding var isShowing: Bool

    // Ensure the notification appears flush with the top edge of the screen
    private var topOffset: CGFloat {
        guard let window = UIApplication.shared.windows.first else { return 0 } // Fallback to 0 if no window is found
        return window.safeAreaInsets.top // Only account for the safe area top inset
    }
    
    var body: some View {
        if isShowing {
            Text(text)
                .padding()
                .background(Color.black.opacity(0.75))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                .offset(y: isShowing ? topOffset : -100) // Slide in from above the screen to the top edge
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                }
        }
    }
}
