//
//  CustomTextEditorView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 14/11/23.
//

/**
 A custom text editor view with a placeholder.

 This view is designed to provide a text editor with a placeholder, similar to a `TextField`.
 */

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
