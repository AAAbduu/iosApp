//
//  ContentView.swift
//  App
//
//  Created by Abdurrahim Ali on 16/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showSideMenu = false
    @State private var showWalletMenu = false
    let user : User
    var body: some View {
        mainView
    }
}


extension ContentView{
    var mainView: some View{
        
        ZStack(alignment: showSideMenu ? .topLeading : .topTrailing){
            NavigationBar()
                .toolbar(showWalletMenu || showSideMenu ? .hidden: .visible)
            
            if showWalletMenu{
                ZStack{
                    Color(.black).opacity(showWalletMenu ? 0.3 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeOut){
                        showWalletMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            if showSideMenu{
                ZStack{
                    Color(.black).opacity(showSideMenu ? 0.3 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeOut){
                        showSideMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            WalletView()
                .frame(width: 330)
                .offset(x: showWalletMenu ? 0: 400, y:0)
            
            SelfUserProfileView(user: user)
                .frame(width: 330)
                .offset(x: showSideMenu ? 0: -400, y:0)
            
            
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button{
                    withAnimation(.easeInOut){
                        showSideMenu.toggle()
                        showWalletMenu = false
                    }
                } label: {
                    Circle()
                        .frame(width: 32, height: 32)
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Button{
                    withAnimation(.easeInOut){
                        showWalletMenu.toggle()
                        showSideMenu = false
                    }
                } label: {
                    Circle()
                        .frame(width: 32, height: 32)
                }
            }
        }
    }
}

#Preview {
    ContentView(user: User(userAt: "p", userEmail: "email", username: "p", followedUsers: 0, followedUsersAts: nil))
}
