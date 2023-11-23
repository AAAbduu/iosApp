//
//  ConfirmCodeSignUpView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 7/11/23.
//

import SwiftUI

struct ConfirmCodeSignUpView: View {
    @StateObject private var vM = ConfirmSignUpModelView()
    let userName: String
    @State private var textcode = ""
    var body: some View {
        VStack{
            Spacer()
            Text("Confirm your account")
                .font(.largeTitle)
            Text(userName)
                .font(.title3)
                .padding(.bottom, 42.0)
            
            
            
            Text("We have sent you an e-mail")
                .font(.caption)
            
            Text("Please check your inbox for a confirmation code")
                .font(.caption)
                .padding(.bottom, 32.0)
            
            InputField(text: $textcode, image: "envelope", placeHolder: "Confirmation code", isSecureField: false)
                .frame(width: 300)
            
            Button("Confirm"){
                vM.confirmCode(username: userName, code: textcode)
            }
            .padding(.top)
            
            Spacer()
        }
    }
}

#Preview {
    ConfirmCodeSignUpView(userName : "Pedro")
}
