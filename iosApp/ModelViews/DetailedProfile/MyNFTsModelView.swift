//
//  MyNFTsModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 22/12/23.
//

/**
 A view model class for managing the retrieval of claimed NFTs.

 This class is responsible for fetching and managing the claimed NFTs associated with the current user.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `claimedNfts` property is marked as `@Published` to automatically notify subscribers of changes.
 */

import Foundation
class MyNFTsModelView : ObservableObject{
    @Published var claimedNfts : [Post] = []
    let model = ModelMain.shared
    init(){
        getClaimedNfts()
    }
    
    func getClaimedNfts(){
        self.model.updateCurrentUser()
        if let user = self.model.currentUser{
            Task{
                try await user.claimedNFTs?.fetch()
                DispatchQueue.main.async{
                    if let nfts = user.claimedNFTs?.elements{
                        self.claimedNfts = nfts
                    }
                }
            }
        }
        
        
    }
}
