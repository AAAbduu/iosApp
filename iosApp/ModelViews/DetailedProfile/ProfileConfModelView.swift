//
//  ProfileConfModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 9/11/23.
//

import Foundation

class ProfileConfModelView : ObservableObject{
    let model = ModelMain.shared
    
    
    func signOut(){
        Task.detached {
            await self.model.signOutLocally()
        }
    }
    
}
