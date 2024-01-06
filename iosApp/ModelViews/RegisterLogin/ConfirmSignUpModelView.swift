//
//  ConfirmCodeSignUpModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 8/11/23.
//

/**
 A view model class for confirming user sign-up with a verification code.

 This class is responsible for confirming the sign-up of a user by providing the necessary verification code.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
 */

import Foundation

class ConfirmSignUpModelView : ObservableObject{
    
    let model = ModelMain.shared

    func confirmCode(currentUser: User, code: String){
        Task.detached{
            await self.model.confirm(currentUser: currentUser, code: code)
        }
    }
}
