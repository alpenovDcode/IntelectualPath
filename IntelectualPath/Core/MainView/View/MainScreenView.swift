//
//  MainScreenView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct MainScreenView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var authViewModel: AuthenticationViewModel  // Uses EnvironmentObject

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        if let user = authViewModel.currentUser {
                            HeaderView(user: user)  // Assumes HeaderView uses the user info
                        }
                        SearchBarView()  // Assuming this doesn't need dynamic data
                        AllCategoriesView()  // Static view assumed
                        RecommendedCoursesView(selectedCourses: $authViewModel.selectedCourses)  // Binding to ViewModel
                    }
                    .padding([.leading, .trailing], 8)
                    .padding(.vertical)
                }
            }
            .tabItem {
                Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                Text("Home")
            }
            .tag(0)
            
            NavigationView {
                            CoursesListView() // No need to pass selectedCourses
                                .navigationTitle("Courses")
                                .environmentObject(authViewModel) // Make sure environmentObject is passed if not globally available
                        }
            .tabItem {
                Image(systemName: selectedTab == 1 ? "book.fill" : "book")
                Text("Learning")
            }
            .tag(1)

            
            NavigationView {
                ProfileView()  // Assuming this is correctly set up
                    .navigationTitle("Profile")
            }
            .tabItem {
                Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                Text("Profile")
            }
            .tag(2)
        }
        .accentColor(.blue)
        .task {
            // This ensures courses are fetched when the view appears
            await authViewModel.fetchUserIfNeeded()
            await authViewModel.fetchUserCourses()
        }
    }
}
