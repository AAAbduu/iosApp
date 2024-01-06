//
//  EditProfileFieldsModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 17/12/23.
//

/**
 A view model class for managing the editing of user profile fields.

 This class is responsible for handling the editing of user profile fields, including username, bio, banner image, and profile image.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `user` property is marked as `@Published` to automatically notify subscribers of changes.
*/

import Foundation
import PhotosUI


class EditProfileFieldsModelView : ObservableObject{
    let model = ModelMain.shared
    
    @Published var user: User?
        
    init() {
        
        if let currentUser = self.model.currentUser {
            self.user = currentUser
        }
    }
    
    
    func editProfileFields(newUserName: String, newBio: String, newBannerImage: UIImage?, newProfileImage: UIImage?){
        if let data = newBannerImage?.pngData(){
            Task.detached{
                if let userAt = self.model.currentUser?.userAt{
                    let result = await self.model.uploadToBucket(key: "bannerImage" + userAt, data: data)
                    self.model.currentUser?.bannerImageKey = result
                    if let user = self.model.currentUser{
                        await self.model.updateUser(updatedModel: user)
                        self.model.updateCurrentUser()
                    }
                }
            }
        }
        if let data = newProfileImage?.pngData(){
            Task.detached{
                if let userAt = self.model.currentUser?.userAt{
                    let result = await self.model.uploadToBucket(key: "profileImage" + userAt, data: data)
                    self.model.currentUser?.profileImageKey = result
                    if let user = self.model.currentUser{
                        await self.model.updateUser(updatedModel: user)
                        self.model.updateCurrentUser()
                    }
                }
            }
        }
        
        if self.model.currentUser?.username != newUserName{ //update username
            self.model.currentUser?.username = newUserName
            Task.detached{
                if let user = self.model.currentUser{
                    await self.model.updateUser(updatedModel: user)
                    self.model.updateCurrentUser()
                }
            }
        }
        
        if self.model.currentUser?.bioDescription != newBio{ //update bio
            self.model.currentUser?.bioDescription = newBio
            Task.detached{
                if let user = self.model.currentUser{
                    await self.model.updateUser(updatedModel: user)
                    self.model.updateCurrentUser()
                }
            }
        }
        
    }
    

    
}
