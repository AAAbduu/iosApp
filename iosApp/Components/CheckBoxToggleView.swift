//
//  CheckBoxToggleView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 4/11/23.
//

import SwiftUI

struct CheckBoxToggleView: View {
    @Binding var isChecked : Bool
    let holdingText: String
    var body: some View {

        HStack {

            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: isChecked ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        isChecked.toggle()
                    }
                }
                
            Spacer()
            Text(holdingText)
            Spacer()
        }
        .frame(width: 250)        
    }
}

#Preview {
    
    CheckBoxToggleView(isChecked: .constant(false) , holdingText: "Hello")
}
