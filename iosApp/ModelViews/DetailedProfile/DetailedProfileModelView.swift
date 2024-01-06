//
//  DetailedProfileModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 24/11/23.
//

/**
 A view model class for managing detailed user profile-related data and actions.

 This class is responsible for handling data related to a specific user's detailed profile, including posts, following status, and actions like follow and unfollow.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `visitedUser`, `posts`, and `following` properties are marked as `@Published` to automatically notify subscribers of changes.

 */

import Foundation

class DetailedProfileModelView : ObservableObject{
    
    let model = ModelMain.shared
        
    @Published var visitedUser: User
    @Published var posts : [Post] = []
    @Published var following: Bool = false
    init(visitedUser: User){
        
        self.visitedUser = visitedUser
        self.getUsersPosts()
        self.model.updateCurrentUser()
        self.following = alreadyFollowing()
    }
    
    func getUsersPosts(){
        Task.detached {
            
            let user = await self.model.getUser(userID: self.visitedUser.id)
            let allPosts = user?.posts
            try await allPosts?.fetch()
            
            if let posts = allPosts {
                DispatchQueue.main.async {
                    self.posts = posts.elements
                }
            }
        }
    }
    
    
    func alreadyFollowing() -> Bool{
        if let result = self.visitedUser.followingUsersAts?.contains(self.model.currentUser?.userAt){
            return result ? true : false
        }
        return false
    }           
    
    func followUser(){
        Task{
            await self.followUser()
        }
    }
    
    private func followUser() async{
        var currentUser = self.model.currentUser
        let cUserAt = self.model.currentUser?.userAt
        if currentUser?.followedUsersAts == nil{
            currentUser?.followedUsersAts = []
        }
        
        if var currentUserU = currentUser{
            currentUserU.followedUsersAts?.append(self.visitedUser.userAt)
            currentUserU.followedUsers += 1
            await self.model.updateUser(updatedModel: currentUserU)
        }
        
        var currentVisited = self.visitedUser
        
        if currentVisited.followingUsersAts == nil {
            currentVisited.followingUsersAts = []
        }
        currentVisited.followingUsersAts?.append(cUserAt)
        currentVisited.followingUsers += 1
        await self.model.updateUser(updatedModel: currentVisited)
        
        DispatchQueue.main.async{
            self.visitedUser.followingUsers += 1
            if self.visitedUser.followingUsersAts == nil{
                self.visitedUser.followingUsersAts = []
            }
            self.visitedUser.followingUsersAts?.append(cUserAt)
            self.following = true
        }
    }
    
    func unfollowUser(){
        Task{
            await self.unfollowUser()
        }
    }
    
    private func unfollowUser() async{
        let currentUser = self.model.currentUser
        let cUserAt = self.model.currentUser?.userAt
        if var currentUserU = currentUser{
            if let itemToRemoveIndex = currentUserU.followedUsersAts?.firstIndex(of: self.visitedUser.userAt) {
                currentUserU.followedUsersAts?.remove(at: itemToRemoveIndex)
            }
            currentUserU.followedUsers -= 1
            await self.model.updateUser(updatedModel: currentUserU)
        }
        
        var currentVisited = self.visitedUser
        
        if let itemToRemoveIndex = currentVisited.followingUsersAts?.firstIndex(of: cUserAt) {
            currentVisited.followingUsersAts?.remove(at: itemToRemoveIndex)
        }
        currentVisited.followingUsers -= 1
        await self.model.updateUser(updatedModel: currentVisited)
        
        DispatchQueue.main.async{
            self.visitedUser.followingUsers -= 1
            if let itemToRemoveIndex = self.visitedUser.followingUsersAts?.firstIndex(of: cUserAt) {
                self.visitedUser.followingUsersAts?.remove(at: itemToRemoveIndex)
            }
            self.following = false
        }
    }
}
