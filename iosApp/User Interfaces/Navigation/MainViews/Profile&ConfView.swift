//
//  Profile&ConfView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//


/**
 A view where configuration will be found
 */
import SwiftUI

struct Profile_ConfView: View {
    @ObservedObject private var vM = ProfileConfModelView()
    var body: some View {
        
        Text("New features coming!! Stay tuned!")
        
        /*Button("Sign out"){
            vM.signOut()
        }*/
    }
}

#Preview {
    Profile_ConfView()
}
