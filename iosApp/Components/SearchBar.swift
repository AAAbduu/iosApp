//
//  SearchBar.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 28/10/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        ZStack{
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .clipShape(.capsule)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.leading, 7.0)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
