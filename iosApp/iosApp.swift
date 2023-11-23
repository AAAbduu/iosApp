//
//  iosAppApp.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/10/23.
//

import SwiftUI




@main
struct iosApp: App {
    @StateObject var model = ModelMain.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                switch model.authState {
                case .signUpSignIn:
                    RegisterLoginView()
                case .confirmSignUp(let username):
                    ConfirmCodeSignUpView(userName: username)
                case .session(let user):
                    ContentView()
                }                
            }
        }
    }
}


