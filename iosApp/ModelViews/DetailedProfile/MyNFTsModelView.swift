//
//  MyNFTsModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 22/12/23.
//

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
