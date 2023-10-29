//
//  ExploreView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    var body: some View {
        VStack{
            
            SearchBar(text: $searchText)
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
