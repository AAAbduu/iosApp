//
//  Register.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/10/23.
//

import SwiftUI

struct Register: View {
    var body: some View {
        ZStack(alignment: .bottom){
                Image(.lightStraightETH)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 550, height: 500)
                    .aspectRatio(contentMode: .fit)
                    
                
                Text("NOMBRE DE LA IDEA")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .frame(width: .infinity, height: 40, alignment: .top)
                
                
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .top)
        .background(.blue) //El gradiente tiene que ir aqui
        
        
        VStack(alignment: .center){
            Text("BIENVENIDO!!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                
            Group{
                Button(action: {print("HELLO Login")}, label: {
                    Text("Log-in")
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.buttonBorder)
                .controlSize(.extraLarge)
                .tint(.purple)
                
                
                Button(action: {print("HELLO Sign")}, label: {
                    Text("Sign-up")
                        .foregroundColor(Color.purple)
                })
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .center)
        
    }
}

#Preview {
    Register()
}
