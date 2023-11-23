//
//  ConfirmCodeSignUpModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 8/11/23.
//

import Foundation

class ConfirmSignUpModelView : ObservableObject{
    
    let model = ModelMain.shared

    func confirmCode(username: String, code: String){
        Task.detached{
            await self.model.confirm(username: username, code: code)
        }
    }
}
