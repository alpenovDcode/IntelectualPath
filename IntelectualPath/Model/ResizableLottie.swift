//
//  ResizableLottie.swift
//  IntelectualPath
//
//  Created by Альпеша on 21.01.2024.
//

import SwiftUI

struct ResizableLottie: UIViewRepresentable {
    @Binding var onboardingItem: OnBoardingItem
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Applying constraints
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),
        ]
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
