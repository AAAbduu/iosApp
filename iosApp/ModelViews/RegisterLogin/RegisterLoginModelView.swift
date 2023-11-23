//
//  RegisterLoginController.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 5/11/23.
//

import Foundation


class RegisterLoginModelView: ObservableObject {
    
    @Published var isBusy : Bool = false
    
    let model = ModelMain.shared
    
    
    func login(userName: String, password: String){
        Task.detached {
            await print(self.model.signIn(username: userName, password: password))
        }
    }
    
    func signup(username: String, password: String, repeatedPassword: String, email: String, acceptedTerms: Bool, acceptedPolicy: Bool) {
        Task.detached {
            await self.model.signup(username: username, password: password, email: email)
        }
    }
    
}
