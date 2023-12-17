//
//  DetailedProfileModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 24/11/23.
//

import Foundation

class DetailedProfileModelView : ObservableObject{
    
    let model = ModelMain.shared
    
    @Published var posts : [Post] = []
    init(){
        self.getUsersPosts()
    }
    
    func getUsersPosts(){
        Task.detached {
            if let id = self.model.currentUser?.id{
                let user = await self.model.getUser(userID: id)
                let allPosts = user?.posts
                try await allPosts?.fetch()

                if let posts = allPosts{
                    self.posts = posts.elements
                }

            }
        }
    }
}
