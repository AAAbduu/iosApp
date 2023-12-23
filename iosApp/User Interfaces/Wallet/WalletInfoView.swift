//
//  WalletInfoView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 24/10/23.
// This view is representing the wallet information once the wallet has being added to the account.

import SwiftUI

struct WalletInfoView: View {
    var body: some View {
        HStack(alignment: .top){
            /*VStack(alignment: .center){
             ZStack {
             HStack(spacing: 0) {
             Text("0x")
             Text("hol")
             Text("...")
             Text("FFFF")
             }
             .font(.callout)
             .fontWeight(.medium)
             .frame(width: 120, height: 20)
             }
             .background(
             Capsule()
             .fill(Color.blue)
             .frame(width: 120, height: 25)
             )
             
             Text("0.995 ETH")
             .font(.largeTitle)
             .fontWeight(.heavy)
             .padding(.top, 6.0)
             
             Text("$180.54 USD")
             .font(.subheadline)
             .fontWeight(.semibold)
             
             }
             .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
             
             Image(systemName: "checkmark.circle.fill")
             .resizable()
             .padding([.bottom, .trailing], 6.0)
             .frame(width: 24, height: 24)
             }
             .frame(maxWidth: .infinity, minHeight: 130)
             .border(Color.black)*/
            
            Text("This feature will be upcoming soon! Meanwhile all nfts in the posts will be free!")
                .padding(.horizontal)
            
        }
        .frame(maxWidth: .infinity, minHeight: 130)
        .border(Color.black)
    }
}

#Preview {
    WalletInfoView()
}
