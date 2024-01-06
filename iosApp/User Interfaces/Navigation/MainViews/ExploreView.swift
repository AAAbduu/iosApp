//
//  ExploreView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

/**
 A view for the explore tab, allow user input and shows result if found in the backend data
 */

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    private var imageExplore = "magnifyingglass"
    @StateObject private var vM = ExploreModelView()

    var body: some View {
        VStack{
            
            InputField(text: $searchText, image: imageExplore, placeHolder: "Search @", isSecureField: false)
                .textInputAutocapitalization(.never)
                .onAppear(perform: {
                    vM.searchUserByInput(userAt: searchText)
                })
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
