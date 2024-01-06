//
//  WalletModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/12/23.
//

/**
 A view model class for managing wallet-related data and interactions.

 This class is responsible for handling data related to wallet functionality, such as retrieving the Ether (ETH) to USD exchange rate.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
    - The `dollarPrice` property is marked as `@Published` to automatically notify subscribers of changes.

 */

import Foundation
class WalletModelView : ObservableObject{
    let model = ModelMain.shared
    @Published var dollarPrice = 0.0
    
    init(){
        getEthDollar()
    }
    
    func getEthDollar(){
        Task{
            let priceUSD = await self.model.ethPriceConversionAPI()
            DispatchQueue.main.async{
                self.dollarPrice = priceUSD
            }
        }
    }
}
