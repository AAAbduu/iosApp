//
//  SelfUserProfileModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/12/23.
//

import Foundation
class SelfUserProfileModelView: ObservableObject{
    let model = ModelMain.shared
    
    func logout(){
        Task{
            await self.model.signOutLocally()
        }
    }
}
