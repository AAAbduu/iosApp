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
        ZStack(alignment: .topLeading){
            NavigationBar()
            
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Circle()
                    .frame(width: 32, height: 32)
            }
            ToolbarItem(placement: .topBarTrailing){
                Button{
                    showWalletMenu.toggle()
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
