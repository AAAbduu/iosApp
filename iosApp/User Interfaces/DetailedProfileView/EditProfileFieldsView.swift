//
//  EditProfileFieldsView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 17/12/23.
//

/**
 A view for editing user profile fields.

 This view allows the user to edit their profile information, including username, bio, and profile images.
 */

import SwiftUI
import PhotosUI

struct EditProfileFieldsView: View {
    @State private var username = ""
    @State private var bio = ""
    
    @State private var profilePicker: PhotosPickerItem?
    @State private var bannerPicker: PhotosPickerItem?
    
    @State private var bannerImage: UIImage?
    @State private var profileImage: UIImage?
    @StateObject private var vM = EditProfileFieldsModelView()
    
    let user : User
    
    var body: some View {
        VStack{
            ZStack{
                PhotosPicker(selection: $bannerPicker) {
                    if self.vM.model.currentBannerImage == nil || bannerImage != nil{
                        Image(uiImage: (bannerImage ?? UIImage(resource: .black)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(Color.black)
                            .frame( height: 175)
                            .clipShape(.rect)
                    }else{
                        Image(uiImage: (self.vM.model.currentBannerImage ?? UIImage(resource: .black)))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(Color.black)
                            .frame( height: 175)
                            .clipShape(.rect)
                    }
                }
                PhotosPicker(selection: $profilePicker) {
                    if self.vM.model.currentProfileImage == nil || profileImage != nil{
                        Image(uiImage: profileImage ?? UIImage(resource: .blue))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(.circle)
                            .padding(.top, 170.0)
                    }else{
                        Image(uiImage: self.vM.model.currentProfileImage ?? UIImage(resource: .blue))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(.circle)
                            .padding(.top, 170.0)
                    }
                    
                        
                }
                              }
            EditableField(title: "Username", value: $username, disabled: false, disablingText: "")
            EditableField(title: "Bio", value: $bio, disabled: false, disablingText: "")
                
            Spacer()
            if user.isContentCreator{
                Text("You are a content creator!")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
            }else{
                Text("You are not a content creator")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
            }
            Spacer()
            
            Button(action: { //Button to submit changes
                vM.editProfileFields(newUserName: username, newBio: bio, newBannerImage: bannerImage, newProfileImage: profileImage)
            }, label: {
                Text("Save changes")
            })
        }.onChange(of: bannerPicker) { _ , _ in
            Task{
                if let bannerPicker,
                   let data = try await bannerPicker.loadTransferable(type: Data.self){
                    if let image = UIImage(data: data){
                        bannerImage = image
                    }
                }
                bannerPicker = nil
            }
        }
        .onChange(of: profilePicker) { _ , _ in
            Task{
                if let profilePicker,
                   let data = try await profilePicker.loadTransferable(type: Data.self){
                    if let image = UIImage(data: data){
                        profileImage = image
                    }
                }
                profilePicker = nil
            }
        }
    }
}



#Preview {
    EditProfileFieldsView(user: User(id: "", userAt: "", userEmail: "", username: "", followingUsers: 0, isContentCreator: false, followingUsersAts: nil, followedUsers: 0, followedUsersAts: nil, bioDescription: "", posts: nil))
}

struct EditableField: View {
    var title: String
    @Binding var value: String
    var disabled : Bool
    var disablingText : String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
            TextField("", text: $value)
                .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .disabled(disabled)
            if disabled{
                Text(disablingText)
            }
        }
        .padding(.horizontal)
    }
}
