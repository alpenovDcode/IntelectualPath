//
//  MainScreenView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct MainScreenView: View {
    @State private var selectedTab = 0
    @State private var selectedCourses: [Course] = []
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var recommendedCoursesViewModel = RecommendedCoursesViewModel()
    @State private var showErrorMessage = false
    @State private var showSuccessMessage = false
    @State private var messageText = ""
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Main Content
                switch selectedTab {
                case 0:
                    NavigationView {
                        ScrollView {
                            VStack(alignment: .center, spacing: 10) {
                                if let user = authViewModel.currentUser {
                                    HeaderView(user: user)
                                }
                                SearchBarView()
                                AllCategoriesView(recommendedCoursesViewModel: recommendedCoursesViewModel)
                                RecommendedCoursesView(viewModel: recommendedCoursesViewModel, selectedCourses: $selectedCourses, showErrorMessage: $showErrorMessage, showSuccessMessage: $showSuccessMessage, messageText: $messageText)
                                    .environmentObject(authViewModel)
                                UsefulArticlesView(articles: sampleArticles)
                            }
                            .padding(.vertical)
                        }
                    }
                case 1:
                    NavigationView {
                        CoursesListView().environmentObject(authViewModel)
                    }
                case 2:
                    NavigationView {
                        ProfileView()
                    }
                case 3:
                    if authViewModel.isAuthenticated {
                            CreateNewsView(viewModel: newsViewModel)
                    } else {
                            NewsListView(viewModel: newsViewModel)
                    }
                case 4:
                        NewsListView(viewModel: newsViewModel)
                default:
                    Text("Selection does not exist")
                }
                CustomTabBar(selectedTab: $selectedTab, isAuthenticated: authViewModel.isAuthenticated) // Pass authentication status
            }
            .edgesIgnoringSafeArea(.bottom)
            .overlay(
                ToastView(text: showErrorMessage ? messageText : "Курс \(messageText) успешно добавлен", isShowing: showErrorMessage ? $showErrorMessage : $showSuccessMessage)
                    .padding(.top, -40)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                    .zIndex(1)
            )
        }
        .task {
            await authViewModel.fetchUserIfNeeded()
            await authViewModel.fetchUserCourses()
        }
    }
}

//struct MainScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreenView()
//            .environmentObject(AuthenticationViewModel()) // You might need to provide mock data or a dummy view model here
//            .environmentObject(RecommendedCoursesViewModel()) // You might need to provide mock data or a dummy view model here
//            .environmentObject(NewsViewModel())
//    }
//}
