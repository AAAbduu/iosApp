//
//  ContentModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 20/12/23.
//

import Foundation

class ContentModelView : ObservableObject {
    let model = ModelMain.shared
    @Published var currentUser : User?
    
    init(){
        self.currentUser = getUser()
    }
    
    private func getUser() -> User?{
        self.model.updateCurrentUser()
        return self.model.currentUser
    }
}
