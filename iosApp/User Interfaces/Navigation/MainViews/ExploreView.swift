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
    var body: some View {
        VStack{
            
            InputField(text: $searchText, image: imageExplore, placeHolder: "Search", isSecureField: false)
            ScrollView{
                LazyVStack(spacing: 0){
                    ForEach(0 ... 7, id: \.self) { _ in
                            ProfilePreview()
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
