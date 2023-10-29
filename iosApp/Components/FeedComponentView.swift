//
//  FeedComponentView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 18/10/23.
//

import SwiftUI

struct FeedComponentView: View {
    var body: some View {
        VStack(alignment: .leading ){
            //Here is content creator image and usrname
            HStack(){
                Rectangle()
                    .frame(width: 64, height: 64)
                Text("@SomeCreatorUsername")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("Time")
                    .font(.caption)
                
            }
            //This is the content of a post. It should not exceed more than 3 lines of text.
            Text("Here is the content of the post created by the content creator")
                .padding(.leading, 64)
            //Here is a graphical rsc of what is to be found and the button to get in the post
            HStack(alignment: .bottom){
                Rectangle()
                    .frame(width: 250, height: 120)
                NavigationLink(destination: DetailedNftView()){
                    Circle()
                        .frame(width: 56, height: 56)
                }
            }
            .padding(.leading, 64)
            
        }
        
        .padding(.horizontal)
        
        Divider()
            .frame(minHeight: 0.4)
            .overlay(Color.gray)
    }
}

#Preview {
    FeedComponentView()
}
