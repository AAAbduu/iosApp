//
//  ContentView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showWalletMenu = false
    var body: some View {
        ZStack(alignment: .topTrailing){
            NavigationBar()
                .toolbar(showWalletMenu ? .hidden: .visible)
            
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
            
            WalletView()
                .frame(width: 330)
                .offset(x: showWalletMenu ? 0: 330, y:0)
            
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Circle()
                    .frame(width: 32, height: 32)
            }
            ToolbarItem(placement: .topBarTrailing){
                Button{
                    withAnimation(.easeInOut){
                        showWalletMenu.toggle()
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
    ContentView()
}
