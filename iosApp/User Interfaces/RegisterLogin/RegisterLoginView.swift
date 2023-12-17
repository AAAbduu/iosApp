//
//  Register.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 16/10/23.
//

import SwiftUI

enum RegisterLoginViewButton {
    case none
    case register
    case login
}

struct RegisterLoginView: View {
    
    @StateObject private var vM = RegisterLoginModelView()
    
    //Animation variables
    @State private var toolbarHeight: CGFloat = 600
    @State private var logoSize = [800.0, 400.0]
    @State private var offSetLogo = [0.0, 0.0]
    @State private var appNameYOffset = 250.0
    @State private var tappedButton : RegisterLoginViewButton = .none
    
    //Data capture for viewModel
    @State private var username = "abdu"
    @State private var password = ""
    @State private var passwordRepeat = ""
    @State private var email = ""
    @State private var termsAccepted = false
    @State private var pPolicyAccepted = false
    
    
    
    var body: some View {
        
        logoName
        
        
        loginView
        
        
        signUpView
        
        if tappedButton == .none{
            Spacer()
            initialLoginSignupButton
        }
    }
}

#Preview {
    RegisterLoginView()
}

extension RegisterLoginView {
    //logo and name goes here
    var logoName: some View{
        ZStack() {
            // Animate the toolbar's height
            Rectangle()
                .frame(height: toolbarHeight)
                .foregroundColor(Color.purple) // Set the color of the toolbar content
            
            Image(.lightStraightETH)
                .resizable()
                .frame(width: logoSize[0], height: logoSize[1])
                .offset(x: offSetLogo[0], y: offSetLogo[1])
                .padding()
            
            Text("App Name")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(x: 0, y: appNameYOffset)
            
            
        }
    }
    
    var initialLoginSignupButton: some View{
        Group{
            Button("Log in"){
                tappedButton = .login
                withAnimation(){
                    toolbarHeight = 400
                    logoSize[0] = 600
                    logoSize[1] = 300
                    offSetLogo[0] = 0
                    offSetLogo[1] = 0
                    appNameYOffset = 160
                    
                }
            }
            
            Button("Sign-up") {
                tappedButton = .register
                withAnimation (){
                    // Change the height of the toolbar
                    toolbarHeight = 65 // Adjust the desired height
                    logoSize[0] = 150
                    logoSize[1] = 80
                    offSetLogo[0] = -160
                    offSetLogo[1] = 0
                    appNameYOffset = 0.0
                }
            }
        }
    }
    
    var loginView: some View{
        //Login animated view goes here
        Group{
            if tappedButton == .login{
                
                VStack(){
                    Spacer()
                    Text("Welcome back!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    
                    InputField(text: $username, image: "person", placeHolder: "Username", isSecureField: false)
                        .frame(width: 300)
                        .padding(5.0)
                        .textInputAutocapitalization(.never)

                    InputField(text: $password, image: "lock", placeHolder: "Password", isSecureField: true)
                        .frame(width: 300)
                        .textInputAutocapitalization(.never)

                    
                    Button("Log in"){
                        vM.login(userName: username, password: password)
                    }
                    .padding(.top)
                    Spacer()
                    Text("Don't have an account yet?")
                    
                    Button("Sign-up"){
                        tappedButton = .register
                        withAnimation (){
                            // Change the height of the toolbar
                            toolbarHeight = 65 // Adjust the desired height
                            logoSize[0] = 150
                            logoSize[1] = 80
                            offSetLogo[0] = -160
                            offSetLogo[1] = 0
                            appNameYOffset = 0.0
                        }
                    }
                    
                }
            }
        }
    }
    var signUpView: some View {
        Group {
            if tappedButton == .register {
                Spacer()
                VStack(spacing: 16) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 21.0)
                    
                    InputField(text: $username, image: "person", placeHolder: "Username", isSecureField: false)
                        .frame(width: 300)
                        .textInputAutocapitalization(.never)

                    InputField(text: $password, image: "lock", placeHolder: "Password", isSecureField: true)
                        .frame(width: 300)
                        .textInputAutocapitalization(.never)

                    InputField(text: $passwordRepeat, image: "lock", placeHolder: "Repeat password", isSecureField: true)
                        .frame(width: 300)
                        .textInputAutocapitalization(.never)

                    InputField(text: $email, image: "envelope", placeHolder: "E-mail", isSecureField: false)
                        .frame(width: 300)
                        .textInputAutocapitalization(.never)
                    
                    CheckBoxToggleView( isChecked: $termsAccepted,holdingText: "Accept terms and services")
                    CheckBoxToggleView(isChecked:$pPolicyAccepted ,holdingText: "Accept privacy policy")
                    
                    Button("Sign up") {
                        vM.signup(username: username, password: password, repeatedPassword: passwordRepeat, email: email, acceptedTerms: termsAccepted, acceptedPolicy: pPolicyAccepted)
                    }
                    .padding(.top, 36.0)
                }
                
                Spacer()
                Text("Have an account already?")
                
                Button("Log-in") {
                    tappedButton = .login
                    withAnimation() {
                        toolbarHeight = 400
                        logoSize[0] = 600
                        logoSize[1] = 300
                        offSetLogo[0] = 0
                        offSetLogo[1] = 0
                        appNameYOffset = 160
                    }
                }
            }
        }
    }
}
