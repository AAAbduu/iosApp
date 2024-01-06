//
//  FeedComponentView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 18/10/23.
//

/**
 A SwiftUI view that represents a component of the feed displaying details of a post.

 This view includes information such as the content creator's image and username, the post content, and a graphical resource along with a button to view the detailed post.

 - Parameter post: The post object containing details to be displayed.
 - Parameter dateFormatter: A `DateFormatter` for formatting the post's timePosted property.

 */

import SwiftUI

struct FeedComponentView: View {
    let post: Post
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    var body: some View {
        VStack(alignment: .leading ){
            //Here is content creator image and usrname
            HStack(){
                Rectangle()
                    .frame(width: 64, height: 64)
                Text("@\(post.postOwner.userAt)")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                Spacer()
                //Text(post.timePosted, formatter: dateFormatter)
                  //  .font(.caption)
                
            }
            .padding(.top)
            //This is the content of a post. It should not exceed more than 3 lines of text.
            Text(post.postContent)
                .padding(.leading, 64)
            //Here is a graphical rsc of what is to be found and the button to get in the post
            HStack(alignment: .bottom){
                Rectangle()
                    .frame(width: 250, height: 120)
                NavigationLink(destination: DetailedNftView(post: post)){
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
    FeedComponentView(post: Post(postOwner: User(userAt: "abdu", followingUsers: 0, isContentCreator: false, followedUsers: 0), postContent: "", geoGraphicalPostPosition: GeoGraphicalData(logitudeDDegrees: 0, latitudeDDegrees: 0)))
}
