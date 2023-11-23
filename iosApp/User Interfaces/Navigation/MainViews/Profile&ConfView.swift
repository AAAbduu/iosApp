//
//  Profile&ConfView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

import SwiftUI

struct Profile_ConfView: View {
    @ObservedObject private var vM = ProfileConfModelView()
    var body: some View {
        Button("Sign out"){
            vM.signOut()
        }
    }
}

#Preview {
    Profile_ConfView()
}
