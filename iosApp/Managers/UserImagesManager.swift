//
//  UserImagesManager.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/12/23.
//  This manager will take care of getting the resources of images necessary for each user.

import Foundation
import PhotosUI
class UserImagesManager : ObservableObject{
    @Published var currentBannerImage: UIImage? = nil
    @Published var currentProfileImage: UIImage? = nil
    let model = ModelMain.shared
    
    init(user: User){
        getProfilePic(user: user)
        getBannerPic(user: user)
    }
    
    func getProfilePic(user: User){
        Task{
            let result = await self.model.getAnyProfileImage(user: user)
            DispatchQueue.main.async{
                self.currentProfileImage = result
            }
        }
    }
    
    func getBannerPic(user: User){
        Task{
            let result = await self.model.getAnyBannerImage(user: user)
            DispatchQueue.main.async{
                self.currentBannerImage = result
            }
        }
    }
}
