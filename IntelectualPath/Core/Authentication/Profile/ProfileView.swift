//
//  ProfileView.swift
//  IntelectualPath
//
//  Created by Альпеша on 22.01.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var isEditProfileViewVisible = false
    @State private var isAccountDeleted = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
               Section {
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(.gray)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                
                Section("General") {
                    HStack{
                        SettingsRawView(imageName: "gear",
                                        title: "App Version",
                                        tintColor: .gray)
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Profile info") {
                    Button {
                        isEditProfileViewVisible.toggle()
                    } label: {
                        SettingsRawView(imageName: "pencil",
                                        title: "Edit profile",
                                        tintColor: .gray)
                    }
                }.sheet(isPresented: $isEditProfileViewVisible) {
                    EditProfileView()
                }

                Section("Account") {
                    Button {
                        viewModel.signOut()
                        presentationMode.wrappedValue.dismiss() // Dismiss the ProfileView
                    } label: {
                        SettingsRawView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: .red)
                    }
                    Button {
                        Task {
                            await deleteAccount()
                        }
                    } label: {
                        SettingsRawView(imageName: "xmark.circle.fill",
                                        title: "Delete account",
                                        tintColor: .red)
                    }
                }
            }
        }
    }
    
    private func deleteAccount() async {
        do {
            await viewModel.deleteUser()
            isAccountDeleted = true
        } catch {
            print("Failed to delete account with error: \(error.localizedDescription)")
        }
    }
}
