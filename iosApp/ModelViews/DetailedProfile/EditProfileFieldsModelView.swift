//
//  EditProfileFieldsModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 17/12/23.
//

import Foundation
import PhotosUI


class EditProfileFieldsModelView : ObservableObject{
    let model = ModelMain.shared
    
    @Published var user: User?
    @Published var currentBannerImage: UIImage?
    @Published var currentProfileImage: UIImage?
        
    init() {
        
        if let currentUser = self.model.currentUser {
            self.user = currentUser
        }
        self.currentBannerImage = self.getBannerImage()
        self.currentProfileImage = self.getProfileImage()
    }
    
    
    func editProfileFields(newUserName: String, newBio: String, newBannerImage: UIImage?, newProfileImage: UIImage?){
        if let data = newBannerImage?.pngData(){
            Task.detached{
                if let userAt = self.model.currentUser?.userAt{
                    let result = await self.model.uploadToBucket(key: "bannerImage" + userAt, data: data)
                    self.model.currentUser?.bannerImageKey = result
                    if let user = self.model.currentUser{
                        await self.model.updateUser(updatedModel: user)
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
                    }
                }
            }
        }
        
        if self.model.currentUser?.username != newUserName{ //update username
            self.model.currentUser?.username = newUserName
            Task.detached{
                if let user = self.model.currentUser{
                    await self.model.updateUser(updatedModel: user)
                }
            }
        }
        
        if self.model.currentUser?.bioDescription != newBio{ //update bio
            self.model.currentUser?.bioDescription = newBio
            Task.detached{
                if let user = self.model.currentUser{
                    await self.model.updateUser(updatedModel: user)
                }
            }
        }
        
    }
    
    func getBannerImage() -> UIImage?{
        return self.model.getBannerImage()
    }
    
    func getProfileImage() -> UIImage?{
        return self.model.getProfileImage()
    }
    
}
