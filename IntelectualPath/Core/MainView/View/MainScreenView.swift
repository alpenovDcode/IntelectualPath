//
//  MainScreenView.swift
//  IntelectualPath
//
//  Created by Альпеша on 05.02.2024.
//

import SwiftUI

struct MainScreenView: View {
    
    @State private var selectedTab = 0
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var isProfileViewActive = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        HeaderView(user: viewModel.currentUser)
                        
                        SearchBarView()
                        
//                        ProgressCardView(user: viewModel.currentUser)
//                            .padding([.top, .bottom], 8)
                        
                        AllCategoriesView()
                        
                        RecommendedCoursesView()
                    }
                    .padding()
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                Text("Home")
            }
            .tag(0)
            
            Text("Learning View")
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "book.fill" : "book")
                    Text("Learning")
                }
                .tag(1)
            
            NavigationView {
                ProfileView()
                    .navigationBarTitle("Profile", displayMode: .inline)
                    .navigationBarItems(
                        trailing: Button(action: {
                            isProfileViewActive.toggle()
                        }, label: {
                            Text("Edit")
                        })
                    )
                    .sheet(isPresented: $isProfileViewActive) {
                        EditProfileView()
                    }
            }
            .tabItem {
                Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                Text("Profile")
            }
            .tag(2)
        }
        .accentColor(.blue)
        .task {
            await viewModel.fetchUser()
        }
    }
}

