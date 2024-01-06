//
//  RegisterLoginController.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 5/11/23.
//

/**
 A view model class for managing user registration and login.

 This class is responsible for handling user registration and login operations, providing functions to sign up and sign in users.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `isBusy` property is marked as `@Published` to automatically notify subscribers of changes.

 */

import Foundation


class RegisterLoginModelView: ObservableObject {
    
    @Published var isBusy : Bool = false
    
    let model = ModelMain.shared
    
    
    func login(userName: String, password: String){
        Task.detached {
            //await self.model.signOutLocally()
            await print(self.model.signIn(username: userName, password: password))
        }
    }
    
    func signup(username: String, password: String, repeatedPassword: String, email: String, acceptedTerms: Bool, acceptedPolicy: Bool) {
        Task.detached {
            await self.model.signup(username: username, password: password, email: email)
        }
    }
    
}
