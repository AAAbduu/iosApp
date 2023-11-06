//
//  iosAppApp.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/10/23.
//

import SwiftUI

@main
struct iosApp: App {
    @StateObject var model = Model.shared
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if (model.isLogggedIn) {
                    ContentView()
                } else {
                    RegisterLoginView()
                }
            }
        }
    }
}
