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
                            ResizableLottieView(onboardingItem: $item)
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
                            Text(isLastSlide ? "Login" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, isLastSlide ? 13 :12)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Capsule()
                                        .fill(.blue)
                                )
                                .padding(.horizontal,isLastSlide ? 30 : 100)
                                .onTapGesture {
                                    // MARK: UPD to next index
                                    let currentProgress = onBoardingItems[currentIndex].lottieView.currentProgress
                                    if currentIndex < onBoardingItems.count - 1 {
                                        // MARK: pause previous animation
                                        onBoardingItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                        currentIndex += 1
                                        // MARK: play next animation
                                        playAnimation()
                                    }
                                }
                            
                            HStack{
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
            .frame(width: size.width * CGFloat(onBoardingItems.count), alignment: .leading)
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

#Preview {
    OnBoardingScreen()
}


// MARK: Resizable lottie view without background
struct ResizableLottieView: UIViewRepresentable {
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
