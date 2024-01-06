//
//  ProfilePreview.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 28/10/23.
//

/**
 A SwiftUI view providing a preview of a user's profile.

 This view includes the user's profile image, username, and user handle. Tapping the view navigates to the detailed profile view.

 - Parameter uIM: An instance of `UserImagesManager` responsible for managing user images.
 - Parameter user: The user for whom the profile preview is displayed.
 */
import SwiftUI

struct ProfilePreview: View {
    @StateObject private var uIM: UserImagesManager
    let user: User

    init(user: User) {
        self.user = user
        self._uIM = StateObject(wrappedValue: UserImagesManager(user: user))
    }
    var body: some View {
        NavigationLink(destination: DetailedProfileView(user: user)) {
            HStack {
                Image(uiImage: uIM.currentProfileImage ?? .blue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
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
