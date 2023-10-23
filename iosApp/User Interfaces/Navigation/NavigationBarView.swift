//
//  NavigationBar.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 19/10/23.
//

import SwiftUI

struct NavigationBar: View {
    @State private var selectedIndex = 0
    var body: some View {
        TabView(selection: $selectedIndex){
            FeedView()
                .onTapGesture {
                    selectedIndex = 0
                }
                .tabItem{
                    Image(systemName: "house")
                }
            ExploreView()
                .onTapGesture {
                    selectedIndex = 1
                }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
            Profile_ConfView()
                .onTapGesture {
                    selectedIndex = 2
                }
                .tabItem{
                    Image(systemName: "person.fill")
                }
        }
    }
}

#Preview {
    NavigationBar()
}
