//
//  ProfileConfModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 9/11/23.
//

/**
 A view model class for managing user profile configuration-related functionalities.

 This class is responsible for handling user profile configuration actions, such as signing out.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.

 Example Usage:
 */

import Foundation

class ProfileConfModelView : ObservableObject{
    let model = ModelMain.shared
    
    
    func signOut(){
        Task.detached {
            await self.model.signOutLocally()
        }
    }
    
}
