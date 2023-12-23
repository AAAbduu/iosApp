//
//  WalletModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/12/23.
//

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
