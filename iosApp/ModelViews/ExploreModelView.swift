//
//  ExploreModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/12/23.
//

import Foundation

class ExploreModelView : ObservableObject{
    
    let model = ModelMain.shared
    @Published var foundUser: User?
    
    private func searchUser(userAt: String) async -> User?{
    
        let userID = await self.model.getUserByUserAt(username: userAt)
            
        if let user = await self.model.getUser(userID: userID ?? "0"){
            return user
        }
        return nil
    }
    
    func searchUserByInput(userAt: String) {
        Task.detached{
            self.foundUser = await self.searchUser(userAt: userAt)
        }
    }
}
