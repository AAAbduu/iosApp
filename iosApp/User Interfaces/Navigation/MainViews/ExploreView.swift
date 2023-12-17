//
//  ExploreView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var imageExplore = "magnifyingglass"
    @StateObject private var vM = ExploreModelView()
    /*User(id: "", userAt: "", userEmail: "", username: "", followingUsers: 0, isContentCreator: false, followingUsersAts: nil, followedUsers: 0, followedUsersAts: nil, bioDescription: "", posts: nil, createdAt: nil, updatedAt: nil)*/
    var body: some View {
        VStack{
            
            InputField(text: $searchText, image: imageExplore, placeHolder: "Search @", isSecureField: false)
                .onChange(of: searchText){
                    vM.searchUserByInput(userAt: searchText)
                }
            
            ScrollView{
                LazyVStack(spacing: 0){
                    //ForEach(0 ... 7, id: \.self) { _ in
                    if let user = vM.foundUser{
                        ProfilePreview(user: user)
                    }
                        //}
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
