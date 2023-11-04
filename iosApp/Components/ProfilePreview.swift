//
//  ProfilePreview.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 28/10/23.
//

import SwiftUI

struct ProfilePreview: View {
    var body: some View {
        NavigationLink(destination: DetailedProfileView()) {
            HStack {
                Circle()
                    .frame(width: 64, height: 64)
                VStack(alignment: .leading) {
                    Text("Content creator name")
                        .fontWeight(.bold)
                    Text("@ContentCreator")
                        .font(.caption)
                }
                Spacer()
            }
            .padding()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfilePreview()
}
