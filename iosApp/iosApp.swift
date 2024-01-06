//
//  iosAppApp.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/10/23.
//

/**
 App entry point
 */

import SwiftUI




@main
struct iosApp: App {
    @StateObject var model = ModelMain.shared


    
    init(){
        LocationManager.shared.requestLocation()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                switch model.authState {
                case .signUpSignIn:
                    RegisterLoginView()
                case .confirmSignUp(let user):
                    ConfirmCodeSignUpView(currentUser: user)
                case .session(_):
                    if let unwUser = self.model.currentUser{
                        ContentView(user: unwUser)


                    }
                }
            }
        }
    }
}


