//
//  SplashScreenView.swift
//  IntelectualPath
//
//  Created by Альпеша on 30.12.2023.
//

import SwiftUI

struct WelcomeScreen: View {
    @State private var isAppLoaded = false
    @State private var isActive = true // Состояние для отслеживания, активен ли приветственный экран

    var body: some View {
        Group {
            if isActive {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    VStack {
                        Image("Logo") // Убедитесь, что в Assets.xcassets есть соответствующий набор ресурсов с именем "Icon"
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        Text("IntellectualPath")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                .opacity(isAppLoaded ? 0 : 1) // Анимация прозрачности для плавного исчезновения
                .animation(.easeInOut(duration: 0.5), value: isAppLoaded)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        // Это пример, предполагающий, что приложение загружается за 2 секунды.
                        // В реальном приложении здесь будет ваша логика загрузки.
                        withAnimation {
                            self.isAppLoaded = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // Даем время анимации на завершение перед сменой экрана
                            self.isActive = false
                        }
                    }
                }
            } else {
               OnBoardingScreen()
            }
        }
    }
}
