//
//  OnBoardingItem.swift
//  IntelectualPath
//
//  Created by Альпеша on 03.01.2024.
//

import SwiftUI
import Lottie

struct OnBoardingItem: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var lottieView: LottieAnimationView = .init()
}
