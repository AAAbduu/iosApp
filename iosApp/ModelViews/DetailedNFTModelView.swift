//
//  DetailedNFTModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 21/12/23.
//
/**
 A view model class for handling detailed information and actions related to a specific NFT (Non-Fungible Token).

 This class is responsible for managing the detailed view of an NFT, including updating its information, checking if it can be claimed, and handling the claiming process.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
 */

import Foundation
import CoreLocation

class DetailedNFTModelView : ObservableObject{
    @Published var post : Post
    let model = ModelMain.shared
    @Published var canBeClaimedValue = false
    
    init(post: Post) {
        self.post = post
        getUpdatedPost(post: post)
        updateCanBeClaimed()
    }
    
    func updateCanBeClaimed() {
        canBeClaimedValue = canBeClaimed()
    }
    
    private func getUpdatedPost(post: Post){
        Task{
            let post = await self.model.getPost(post: post)
            DispatchQueue.main.async{
                if let unwPost = post{
                    self.post = unwPost
                }
            }
        }
    }
    
    func canBeClaimed() -> Bool{
        if let userLocation = LocationManager.shared.userLocation{
            let nftLocation = CLLocationCoordinate2D(latitude: self.post.geoGraphicalPostPosition.latitudeDDegrees, longitude: self.post.geoGraphicalPostPosition.logitudeDDegrees)
            let distance = self.calculateDistance(userLocation: userLocation.coordinate, nftLocation: nftLocation)
            if distance < 10{
                return true
            }
        }
        return false
    }
    
    private func calculateDistance(userLocation: CLLocationCoordinate2D, nftLocation: CLLocationCoordinate2D) -> Double{
        let diffLong = pow((userLocation.longitude - nftLocation.longitude), 2)
        let diffLat = pow((userLocation.latitude - nftLocation.latitude), 2)
        
        let sum = diffLong + diffLat
        
        return sqrt(sum)
    }
    
    func claimPost(){
        
        self.post.whoClaimed = self.model.currentUser
        
        var post = self.post
        
        post.whoClaimed = self.model.currentUser
        post.postStatus = .past //Onnce claimed, already in the past...
        
        self.post = post
        
        Task{
            await self.model.updatePost(post: self.post)
        }
    }
    
}
