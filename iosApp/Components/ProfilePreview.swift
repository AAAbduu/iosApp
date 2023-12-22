//
//  ProfilePreview.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 28/10/23.
//

import SwiftUI

struct ProfilePreview: View {
    let user: User
    var body: some View {
        NavigationLink(destination: DetailedProfileView(user: user)) {
            HStack {
                Circle()
                    .frame(width: 64, height: 64)
                VStack(alignment: .leading) {
                    Text(user.username ?? "error")
                        .fontWeight(.bold)
                    Text("@\(user.userAt)")
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
    ProfilePreview(user: User(userAt: "p", userEmail: "email", username: "p", followingUsers: 0, isContentCreator: false, followedUsers: 0, followedUsersAts: nil))
}
