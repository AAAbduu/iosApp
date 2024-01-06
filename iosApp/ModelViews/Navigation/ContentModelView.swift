//
//  ContentModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 20/12/23.
//


/**
 A view model class for managing content-related data and the current user's information.

 This class is responsible for handling data related to content and the current user, including updating and retrieving user information.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `currentUser` property is marked as `@Published` to automatically notify subscribers of changes.
 */
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
