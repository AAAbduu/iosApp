//
//  ConfirmCodeSignUpView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 7/11/23.
//

/*
  A view for confirming the account sign-up with a confirmation code.

  This view includes UI elements for entering the confirmation code and a button to confirm the sign-up.
 */
import SwiftUI

struct ConfirmCodeSignUpView: View {
    @StateObject private var vM = ConfirmSignUpModelView()
    let currentUser: User
    @State private var textcode = ""
    var body: some View {
        VStack{
            Spacer()
            Text("Confirm your account")
                .font(.largeTitle)
            if let username = currentUser.username{
                Text(username)
                    .font(.title3)
                    .padding(.bottom, 42.0)
            }
            
            
            
            Text("We have sent you an e-mail")
                .font(.caption)
            
            Text("Please check your inbox for a confirmation code")
                .font(.caption)
                .padding(.bottom, 32.0)
            
            InputField(text: $textcode, image: "envelope", placeHolder: "Confirmation code", isSecureField: false)
                .frame(width: 300)
            
            Button("Confirm"){
                vM.confirmCode(currentUser: currentUser, code: textcode)
            }
            .padding(.top)
            
            Spacer()
        }
    }
}

#Preview {
    ConfirmCodeSignUpView(currentUser: User(userAt: "username", userEmail: "email", username: "username", followingUsers: 0, isContentCreator: false, followingUsersAts: nil, followedUsers: 0, followedUsersAts: nil, bioDescription: "", posts: nil))
}
