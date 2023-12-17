//
//  DetailedProfileView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 29/10/23.
//

import SwiftUI

struct DetailedProfileView: View {
    @State private var profileFilter: ProfileFilters = .live
    @Namespace var slideSelectedFilter
    @StateObject var vM = DetailedProfileModelView()
    let user: User
    var body: some View {
        ScrollView{
            
            profilePics
                        
            statsFollow
            
            postSelectedFilter
            
            
            
            LazyVStack{
                ForEach(vM.posts.indices, id: \.self) { index in
                    if vM.posts[index].postStatus?.rawValue == profileFilter.postStatus{
                        FeedComponentView(post: vM.posts[index])
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline) // Set the navigation bar title to inline
    }
}


#Preview {
    DetailedProfileView(user: User(userAt: "p", userEmail: "email", username: "p", followedUsers: 0, followedUsersAts: nil))
}

extension DetailedProfileView{
    var profilePics: some View{
        //Banner and profile pic go here
        ZStack{
            Rectangle()
                .frame(height: 175)
            Circle()
                .padding(.top, 170.0)
                .frame(width: 80)
                .foregroundStyle(Color.blue)
        }
    }
    
    var statsFollow: some View{
        //Follower stats, name and folow/unfollow button
        VStack {
            ZStack(alignment: .center){
                
                VStack(alignment: .center){
                    Text(user.username ?? "error")
                        .font(.headline)
                    Text("@\(user.userAt)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                
                if user.id != vM.model.currentUser?.id{
                    Button(action: {
                        print("Following button")
                    }) {
                        Text("Follow")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                }else{
                    NavigationLink{
                        DetailedProfileView(user: user)
                    }label: {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            
            .padding(.vertical, 5.0)
            
            Text(user.bioDescription ?? "")
            
            HStack{
                let followedUser = String(user.followedUsers ?? 0)
                let followingUsers = String(user.followingUsers ?? 0)
                Text("Following: \(followedUser)")
                Text("Followers: \(followingUsers)")
                Spacer()
            }
            .padding([.top, .leading, .bottom])
        }
    }
    
    var postSelectedFilter: some View{
        HStack{
            ForEach(ProfileFilters.allCases, id: \.rawValue) { item in
                VStack{
                    Text(item.filter)
                    if profileFilter == item{
                        Capsule()
                            .padding(.horizontal, 3)
                            .foregroundStyle(Color.red)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "filter", in: slideSelectedFilter)
                    }else{
                        Capsule()
                            .padding(.horizontal, 3)
                            .foregroundStyle(Color.clear)
                            .frame(height: 4)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        profileFilter = item
                    }
                }
            }
        }
    }

}
