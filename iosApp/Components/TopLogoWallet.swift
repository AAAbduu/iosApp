//
//  TopLogoWallet.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 19/10/23.
//

import SwiftUI

struct TopLogoWallet: View {
    var body: some View {
        HStack(){
            Image(.lightstraightethIcon)
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Image(.wallet50)
        }
        .background(Color.blue)
        .frame(width: .infinity, height: 80)
    }
}
#Preview {
    TopLogoWallet()
}
