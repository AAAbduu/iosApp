//
//  WalletView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

import SwiftUI

struct WalletView: View {
    @State private var selectedWallets: [Bool] = [false, false]
    var body: some View {
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
            .background(Color.white)
        }
    }
}


#Preview {
    WalletView()
}
