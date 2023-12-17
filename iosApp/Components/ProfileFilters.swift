//
//  ProfileFilters.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 30/10/23.
//

import Foundation

enum ProfileFilters: Int, CaseIterable{
    case live
    case upcoming
    case past
    
    var filter: String{
        switch self{
        case .live: return "Live"
        case .upcoming: return "Upcoming"
        case .past: return "Past"
        }
    }
    
    var postStatus: String{
        switch self{
        case .live: return "LIVE"
        case .upcoming: return "UPCOMING"
        case .past: return "PAST"
        }
    }
}
