//
//  CustomTextEditorView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 14/11/23.
//

import SwiftUI

struct CustomTextEditorView: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
            }
            TextEditor(text: $text)
                .opacity(text.isEmpty ? 0.25 : 1)
        }
    }
}
