//
//  FeedModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 20/12/23.
//

/**
 A view model class for managing the feed and post-related data for the current user.

 This class is responsible for handling data related to the user's feed, including retrieving and organizing posts from followed users.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `currentUser` and `currentFeed` properties are marked as `@Published` to automatically notify subscribers of changes.
 */

import Foundation

class FeedModelView : ObservableObject{
    let model = ModelMain.shared
    @Published var currentUser : User?
    @Published var currentFeed : [Post] = []
    
    init(){
        //self.currentFeed = []
        self.currentUser = getUser()
        self.getPostsOfFollowing()
    }
    
    private func getUser() -> User?{
        self.model.updateCurrentUser()
        return self.model.currentUser
    }
    
    func getPostsOfFollowing(){
        Task{
            var finalFeed :[Post] = []
            if let followedAts = self.currentUser?.followedUsersAts{
                for userAt in followedAts{
                    if let unUserAt = userAt{
                        let userID = await self.model.getUserByUserAt(username: unUserAt)
                        if let unUserID = userID{
                            let user = await self.model.getUser(userID: unUserID)
                            try await user?.posts?.fetch()
                            if let userPosts = user?.posts{
                                finalFeed.append(contentsOf: userPosts)
                            }
                        }
                    }
                }
            }
            finalFeed.shuffle()
            let fFeed = finalFeed.filter{$0.whoClaimed == nil}
            DispatchQueue.main.async{
                self.currentFeed = fFeed
            }
        }
    }
}
