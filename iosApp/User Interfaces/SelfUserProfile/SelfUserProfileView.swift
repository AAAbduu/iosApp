//
//  SelfUserProfileView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 14/12/23.
//

import SwiftUI

struct SelfUserProfileView: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            VStack(alignment: .leading){
                Circle()
                    .frame(width: 64, height: 64)
                VStack(alignment: .leading, spacing: 4){
                    Text(user.username ?? "error")
                        .font(.headline)
                    
                    Text("@\(user.userAt)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                HStack{
                    Text("Followers: 0")
                    Text("Following: 0")
                }.padding(.vertical)
            }
            .padding(.horizontal)
            
            ForEach(SideUserMenuItems.allCases, id: \.rawValue){ option in
                HStack(spacing: 16){
                    NavigationLink{
                        if option == .profile{
                            DetailedProfileView(user: user)
                        }else if option == .myNfts{
                            DetailedProfileView(user: user)
                        }
                    }label:{
                        Image(systemName: option.image)
                            .font(.headline)
                            .foregroundStyle(.gray )
                        Text(option.description)
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    
                }
                .frame(height: 52)
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .background(Color.white)
    }
}
#Preview {
    SelfUserProfileView(user: User(userAt: "p", userEmail: "email", username: "p", followedUsers: 0, followedUsersAts: nil))
}

enum SideUserMenuItems: Int, CaseIterable{
    case profile
    case myNfts
    case logout
    
    var description: String{
        switch self{
        case .profile : return "Profile"
        case .myNfts : return "My NFTs"
        case .logout : return "Logout"
        }
    }
    
    var image: String{
        switch self{
        case .profile : return "person"
        case .myNfts : return "backpack"
        case .logout : return "arrow.left.square"
        }
    }
}