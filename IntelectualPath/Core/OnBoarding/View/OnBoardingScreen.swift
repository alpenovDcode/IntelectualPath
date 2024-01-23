//
//  OnBoardingScreen.swift
//  IntelectualPath
//
//  Created by Альпеша on 03.01.2024.
//

import SwiftUI

struct OnBoardingScreen: View {
    @State var onBoardingItems: [OnBoardingItem] = [
        .init(title: "Study",
              subtitle: "Learn any programming languages and confirm the completed material with a quiz.",
              lottieView: .init(name: "Study", bundle: .main)),
        .init(title: "Share",
              subtitle: "Share your knowledge with others. Get feedback from other users.",
              lottieView: .init(name: "Share", bundle: .main)),
        .init(title: "Create",
              subtitle: "Create discussions and solve the problem together with other users.",
              lottieView: .init(name: "Create", bundle: .main))
    ]
    // MARK: Current slide index
    @State var currentIndex: Int = 0
    @State private var isMainViewActive = false
    var body: some View {
        GeometryReader{
            let size = $0.size
            HStack(spacing: 0) {
                ForEach($onBoardingItems){ $item in
                    let isLastSlide = (currentIndex == onBoardingItems.count - 1)
                    VStack{
                        // MARK: Top navigation bar
                        HStack{
                            Button("Back") {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    playAnimation()
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            Spacer(minLength: 0)
                            Button("Skip") {
                                currentIndex = onBoardingItems.count - 1
                                playAnimation()
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .tint(.blue)
                        .fontWeight(.bold)
                        // MARK: Movable slides
                        VStack(spacing: 15){
                            let offset = -CGFloat(currentIndex) * size.width
                            ResizableLottie(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear {
                                    // MARK: Intially playing first slide animation
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play()
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            Text(item.title)
                                .font(.title.bold())
                                .foregroundColor(.black)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            Text(item.subtitle)
                                .font(.system(size:14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        
                        Spacer(minLength: 0)
                        
                        // MARK: Next -> Login button
                        VStack(spacing: 15){
                            Text(isLastSlide ? "Start" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, isLastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Capsule()
                                        .fill(.blue)
                                )
                                .padding(.horizontal, isLastSlide ? 30 : 100)
                                .onTapGesture {
                                    if isLastSlide {
                                        isMainViewActive = true
                                    } else {
                                        let currentProgress = onBoardingItems[currentIndex].lottieView.currentProgress
                                        if currentIndex < onBoardingItems.count - 1 {
                                            onBoardingItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                            currentIndex += 1
                                            playAnimation()
                                        }
                                    }
                                }
                            
                            HStack {
                                Text("Terms of Service")
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
                            .offset(y: 5)
                        }
                    }
                    
                    .animation(.easeInOut, value: isLastSlide)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .background(.white)
            .frame(width: size.width * CGFloat(onBoardingItems.count), alignment: .leading)
            if isMainViewActive {
                withAnimation(.easeInOut) {
                    MainMenuView()
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
    
    func playAnimation() {
        onBoardingItems[currentIndex].lottieView.currentProgress = 0
        onBoardingItems[currentIndex].lottieView.play(toProgress: 0.7)
    }
    
    func indexOf(_ item: OnBoardingItem)->Int {
        if let index = onBoardingItems.firstIndex(of: item) {
            return index
        }
        return 0
    }
}
