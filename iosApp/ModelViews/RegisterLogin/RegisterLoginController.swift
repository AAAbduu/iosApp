//
//  RegisterLoginController.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 5/11/23.
//

import Foundation


class RegisterLoginController: ObservableObject {
    
    @Published var isLoggedIn : Bool = false
    @Published var isBusy : Bool = false
    
    let model = Model.shared
    
    
    func login(userName: String, password: String){
        print(model.login(userName: userName, password: password))
    }
    
}
