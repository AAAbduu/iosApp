//
//  WalletDescr.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

/**
 An enumeration representing different wallet types.

 This enumeration includes cases for different wallet types such as Metamask and Coinbase.

 */

import Foundation

enum WalletDescr: Int, CaseIterable{
    case metamask
    case coinbase
    
    var description: String{
        switch self{
        case .metamask: return "Metamask"
        case .coinbase: return "Coinbase"
        }
    }
    
    
    var images: String{
        switch self{
        case .metamask: return "m.circle"
        case .coinbase: return "c.circle"
        }
    }
    
}
