//
//  DetailedProfileView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 29/10/23.
//

/**
 A detailed view of a user's profile.

 This view displays the user's banner image, profile picture, follower statistics, name, and a follow/unfollow button. If the user is a content creator, it also shows a filter for the user's posts.

 */

import SwiftUI

struct DetailedProfileView: View {
    @State private var profileFilter: ProfileFilters = .live
    @Namespace var slideSelectedFilter
    let user: User
    @StateObject var vM: DetailedProfileModelView
    @StateObject private var uIM: UserImagesManager

       // Initialize with the visited user
       init(user: User) {
           self.user = user
           self._vM = StateObject(wrappedValue: DetailedProfileModelView(visitedUser: user))
           self._uIM = StateObject(wrappedValue: UserImagesManager(user: user))

       }
    
    var body: some View {
        
            
            profilePics
            
            statsFollow
            
            if user.isContentCreator{
                
                postSelectedFilter
                ScrollView{
                    LazyVStack{
                        ForEach(vM.posts.indices, id: \.self) { index in
                            if vM.posts[index].postStatus?.rawValue == profileFilter.postStatus{
                                FeedComponentView(post: vM.posts[index])
                            }
                        }
                    }
                }.navigationBarTitleDisplayMode(.inline) // Set the navigation bar title to inlin
            }else{
                Spacer()
                Text("Are you a content creator?")
                    .font(.title)
                    .padding(.top)
                Text("Please contact us so we can verify you and you can start connecting the real world with WEB3")
                    .font(.callout)
                    .padding(.horizontal)
                Spacer()
            }
            
        }
            
        
}


#Preview {
    DetailedProfileView(user: User(userAt: "p", userEmail: "email", username: "p", followingUsers: 0, isContentCreator: false, followedUsers: 0, followedUsersAts: nil))
}

extension DetailedProfileView{
    var profilePics: some View{
        //Banner and profile pic go here
        ZStack{
            Image(uiImage: (self.uIM.currentBannerImage ?? UIImage(resource: .black)))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(Color.black)
                .frame( height: 175)
                .clipShape(.rect)
            Image(uiImage: self.uIM.currentProfileImage ?? UIImage(resource: .blue))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(.circle)
                .padding(.top, 170.0)
        }
    }
    
    var statsFollow: some View{
        //Follower stats, name and folow/unfollow button
        VStack {
            ZStack(alignment: .center){
                
                VStack(alignment: .center){
                    Text(vM.visitedUser.username ?? "")
                        .font(.headline)
                    Text("@\(vM.visitedUser.userAt)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                
                if user.id != vM.model.currentUser?.id && self.vM.following == false{
                    Button(action: {
                        self.vM.followUser()
                    }) {
                        Text("Follow")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                }else if self.vM.following{
                    Button(action: {
                        self.vM.unfollowUser()
                    }) {
                        Text("Unfollow")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                }else{
                    NavigationLink{
                        EditProfileFieldsView(user: user)
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
                let followedUser = String(vM.visitedUser.followedUsers)
                let followingUsers = String(vM.visitedUser.followingUsers)
                Text("Following: \(followedUser)")
                if vM.visitedUser.isContentCreator{
                    Text("Followers: \(followingUsers)")
                }
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
