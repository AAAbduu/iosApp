//
//  SearchBar.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 28/10/23.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    let image: String
    let placeHolder: String
    let isSecureField : Bool
    var body: some View {
        if !isSecureField{
            ZStack{
                TextField(placeHolder, text: $text)
                    .padding(8)
                    .padding(.horizontal, 24.0)
                    .background(Color(.systemGray6))
                    .clipShape(.capsule)
                Image(systemName: image)
                    .foregroundColor(.black)
                    .padding(.leading, 7.0)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }else{
            ZStack{
                SecureField(placeHolder, text: $text)
                    .padding(8)
                    .padding(.horizontal, 24)
                    .background(Color(.systemGray6))
                    .clipShape(.capsule)
                Image(systemName: image)
                    .foregroundColor(.black)
                    .padding(.leading, 7.0)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    InputField(text: .constant(""), image: "magnifyingglass", placeHolder: "Search", isSecureField: false)
}
