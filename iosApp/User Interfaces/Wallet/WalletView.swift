//
//  WalletView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

/**
 A view displaying wallet information, including the current balance and a list of available wallets.
*/

import SwiftUI

struct WalletView: View {
    @State private var selectedWallets: [Bool] = [false, false]
    @StateObject private var vM = WalletModelView()
    var body: some View {
        VStack{
            HStack{
                Text("1 ETH:")
                    .font(.title)
                    .fontWeight(.black)
                Text("$" + String(format: "%.2f", vM.dollarPrice))
                    .font(.title)
                    .fontWeight(.bold)
            }
            HStack {
                Spacer() // Push the content to the right
                VStack(spacing: 10) {
                    ForEach(Array(WalletDescr.allCases.enumerated()), id: \.element.rawValue) { index, option in
                        HStack(spacing: 10) {
                            Image(systemName: option.images)
                            Text(option.description)
                                .font(.title2)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .rotationEffect(selectedWallets[index] ? .degrees(90) : .degrees(0))
                        }
                        .padding()
                        .border(Color.black)
                        .onTapGesture {
                            withAnimation(.easeOut){
                                selectedWallets[index].toggle()
                            }
                        }
                        if selectedWallets[index]{
                            WalletInfoView()
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
            }
        }.background(Color.white)
    }
}

#Preview {
    WalletView()
}
