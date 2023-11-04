//
//  DetailedNftView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 26/10/23.
//

import SwiftUI
import MapKit

struct DetailedNftView: View {

    var body: some View {
        VStack(alignment: .center){
            //Creator pic and name goes here
            HStack{
                Rectangle()
                    .frame(width: 64, height: 64)
                Text("@ContentCreator")
            }
            .padding()
            //NFT 3d resource and description goes here
            VStack{
                Text("This is a description of the NFT that is just below, full width and 200 height will be given in case some kind of animation wants to be played here.")
                    .padding([.top, .leading, .trailing])
                Rectangle()
                    .frame(width: 1000, height: 200)
                
            }
            //Map goes here, telling the position of the nft just below
        
            Spacer()
            Button(action: {print("Claim")}, label: {Text("Claim")})
                .border(Color.black)
        }
    }
}

#Preview {
    DetailedNftView()
}
