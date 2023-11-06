//
//  Model.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 6/11/23.
//

import Foundation

class Model: ObservableObject {
    @Published var isLogggedIn: Bool = false

    private init() {
        // Initialize your properties here
    }

    // Singleton instance
    static let shared = Model()
    
    func login(userName: String, password: String) -> Bool{
        if userName == password{
            self.isLogggedIn = true
            return true
        }
        return false
    }

}
