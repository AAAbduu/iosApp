//
//  ExploreModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/12/23.
//

/**
 A view model class for managing user exploration and search functionalities.

 This class is responsible for handling data related to user exploration, including searching for users based on their username and filtering content creators.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `foundUser` property is marked as `@Published` to automatically notify subscribers of changes.
 */

import Foundation

class ExploreModelView : ObservableObject{
    
    let model = ModelMain.shared
    @Published var foundUser: User?
    
    private func searchUser(userAt: String) async -> User?{
    
        let userID = await self.model.getUserByUserAt(username: userAt)
            
        if let user = await self.model.getUser(userID: userID ?? "0"){
            return user.isContentCreator ? user : nil //Only able to find contentCreators
        }
        return nil
    }
    
    func searchUserByInput(userAt: String) {
        Task{
            let found = await self.searchUser(userAt: userAt)
            DispatchQueue.main.async{
                self.foundUser = found
            }
        }
    }
}
