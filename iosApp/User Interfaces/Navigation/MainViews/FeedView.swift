//
//  FeedView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 18/10/23.
//

import SwiftUI

struct FeedView: View {
    @State var userWantsPost = false
    @StateObject var vM = FeedModelView()
    
    var body: some View {
        ZStack{
            
            ScrollView{
                if vM.currentFeed.count > 0{
                    LazyVStack{
                        ForEach(vM.currentFeed, id: \.id) { post in
                            FeedComponentView(post: post)
                        }
                    }
                }else{
                    VStack{
                        Spacer()
                        Text("Try following content creators or refresh your view by dragging the view down!")
                            .padding()
                            .font(.largeTitle)
                        Spacer()
                    }
                }
            }
            if vM.currentUser?.isContentCreator ?? true{
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
}
                            
                            

#Preview {
    FeedView()
}
