//
//  DetailedProfileView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 29/10/23.
//

import SwiftUI

struct DetailedProfileView: View {
    @State private var profileFilter: ProfileFilters = .live
    @Namespace var slideSelectedFilter
    var body: some View {
        ScrollView{
            
            profilePics
                        
            statsFollow
            
            postSelectedFilter
            
            LazyVStack{
                ForEach(0 ... 10, id: \.self) { _ in
                    FeedComponentView()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline) // Set the navigation bar title to inline
    }
}


#Preview {
    DetailedProfileView()
}

extension DetailedProfileView{
    var profilePics: some View{
        //Banner and profile pic go here
        ZStack{
            Rectangle()
                .frame(height: 175)
            Circle()
                .padding(.top, 170.0)
                .frame(width: 80)
                .foregroundStyle(Color.blue)
        }
    }
    
    var statsFollow: some View{
        //Follower stats, name and folow/unfollow button
        VStack {
            HStack(alignment: .center){
                Spacer()
                VStack(alignment: .center){
                    Text("Creators Name")
                    Text("@contentCreator")
                }
                .padding(.leading, 70)
                Spacer()
                Button(action: {
                    print("Following button")
                }) {
                    Text("Follow")
                }
                .padding(.trailing)
            }
            .padding(.vertical, 5.0)
            
            Text("Some bio information given by the content creator")
            
            HStack{
                Text("Following")
                Text("Followers")
                Spacer()
            }
            .padding([.top, .leading, .bottom])
        }
    }
    
    var postSelectedFilter: some View{
        HStack{
            ForEach(ProfileFilters.allCases, id: \.rawValue) { item in
                VStack{
                    Text(item.filter)
                    if profileFilter == item{
                        Capsule()
                            .padding(.horizontal, 3)
                            .foregroundStyle(Color.red)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "filter", in: slideSelectedFilter)
                    }else{
                        Capsule()
                            .padding(.horizontal, 3)
                            .foregroundStyle(Color.clear)
                            .frame(height: 4)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        profileFilter = item
                    }
                }
            }
        }
    }

}
