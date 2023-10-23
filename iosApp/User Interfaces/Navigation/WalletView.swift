//
//  WalletView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/10/23.
//

import SwiftUI

struct WalletView: View {
    var body: some View {
        HStack {
            Spacer() // Push the content to the right
            VStack(spacing: 10) {
                ForEach(WalletDescr.allCases, id: \.rawValue) { option in
                    HStack(spacing: 10) {
                        Image(systemName: option.images)
                        Text(option.description)
                            .font(.title2)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .border(Color.black)
                }
                Spacer()
            }
            .frame(width: 300)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .padding()
        }
    }
}


#Preview {
    WalletView()
}
