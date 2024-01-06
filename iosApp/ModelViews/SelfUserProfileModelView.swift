//
//  SelfUserProfileModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/12/23.
//

/**
 A view model class for managing the actions and functionalities related to the user's own profile.

 This class provides methods for logging out the current user.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
 */

import Foundation
class SelfUserProfileModelView: ObservableObject{
    var model = ModelMain.shared
    
    func logout(){
        Task{
            await self.model.signOutLocally()
        }
    }
}
