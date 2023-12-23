//
//  MyNFTsView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 22/12/23.
//

import SwiftUI

struct MyNFTsView: View {
    @StateObject private var vM = MyNFTsModelView()
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(vM.claimedNfts, id: \.id) { nft in
                    FeedComponentView(post: nft)
                }
            }
        }
    }
}

#Preview {
    MyNFTsView()
}
