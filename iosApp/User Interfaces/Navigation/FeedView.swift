//
//  FeedView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 18/10/23.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(0 ... 10, id: \.self) { _ in
                    FeedComponentView()
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
