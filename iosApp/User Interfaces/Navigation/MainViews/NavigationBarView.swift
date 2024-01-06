//
//  NavigationBar.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 19/10/23.
//

/**
 A view that defines the bottom bar navigation
 */

import SwiftUI

//Create an enum for your options
enum Tabs: String{
    case Home
    case Explore
    case Configuration
}

struct NavigationBar: View {
    @State var selectedTab: Tabs = .Home
    var body: some View {
        TabView(selection: $selectedTab){
            FeedView()
                .navigationTitle("Home")
                .tabItem{
                    Image(systemName: "house")
                }
                .tag(Tabs.Home)
                
            ExploreView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tabs.Explore)
            Profile_ConfView()
                .tabItem{
                    Image(systemName: "person.fill")
                }
                .tag(Tabs.Configuration)
        }.navigationTitle(selectedTab.rawValue)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationBar()
}
