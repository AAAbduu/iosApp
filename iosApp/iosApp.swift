//
//  iosAppApp.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/10/23.
//

import SwiftUI

@main
struct iosApp: App {
    @StateObject var vm : RegisterLoginController
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if (vm.isLogged) {
                    ContentView()
                } else {
                    Register()
                }
            }
        }
    }
}
