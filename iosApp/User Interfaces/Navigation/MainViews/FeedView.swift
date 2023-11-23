//
//  FeedView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 18/10/23.
//

import SwiftUI

struct FeedView: View {
    @State var userWantsPost = false

    var body: some View {
        ZStack{
            
            ScrollView{
                LazyVStack{
                    ForEach(0 ... 10, id: \.self) { _ in
                        FeedComponentView()
                    }
                }
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut){
                            userWantsPost = true
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .foregroundStyle(Color.purple)
                        
                    }
                    
                    .padding([.bottom, .trailing])
                    .fullScreenCover(isPresented: $userWantsPost, content: {
                        PostPublishView(show: $userWantsPost)
                    })
                }
            }
        }
    }
}
                            
                            

#Preview {
    FeedView()
}
