//
//  DetailedNftView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 26/10/23.
//

import SwiftUI
import MapKit

struct DetailedNftView: View {
    let post: Post
    @State private var cameraPosition: MapCameraPosition = .automatic
    @StateObject var vM: DetailedNFTModelView
    private var coordinates = CLLocationCoordinate2D()
    @State private var canBeClaimed = false
    init(post: Post){
        self.post = post
        self.coordinates.animatableData.first = post.geoGraphicalPostPosition.latitudeDDegrees
        self.coordinates.animatableData.second = post.geoGraphicalPostPosition.logitudeDDegrees
        self._vM = StateObject(wrappedValue: DetailedNFTModelView(post: post))
        
    }
    var body: some View {
        VStack(alignment: .center){
            //Creator pic and name goes here
            HStack{
                Circle()
                    .frame(width: 64, height: 64)
                Text("@\(post.postOwner.userAt)")
            }
            .padding()
            //NFT 3d resource and description goes here
            VStack{
                Text(post.postContent)
                    .padding([.top, .leading, .trailing])
                Rectangle()
                    .frame(width: 1000, height: 200)
                
            }
            Map(position: $cameraPosition){
                Marker("NFT", coordinate: self.coordinates)
            }
            .frame(height: .infinity)
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
            }
            
            Spacer()
            if vM.post.whoClaimed == nil{
                Button(action: { vM.claimPost()}, label: { Text("Claim") })
                    .onChange(of: LocationManager.shared.userLocation) { _, _ in
                        vM.updateCanBeClaimed()
                    }
                    .disabled(!vM.canBeClaimedValue)
            }else{
                Text("This NFT has been claimed by \(vM.post.whoClaimed?.userAt ?? "none")")
            }
        }
    }
    
}

#Preview {
    DetailedNftView(post: Post(id: "", postOwner: User(id: "", userAt: "", userEmail: "", username: "", followingUsers: 0, isContentCreator: true, followingUsersAts: nil, followedUsers: 0, followedUsersAts: nil, bioDescription: "", profileImageKey: "", bannerImageKey: "", posts: nil), postContent: "", postStatus: nil, graphicalResourceKey: "", geoGraphicalPostPosition: GeoGraphicalData(logitudeDDegrees: 0, latitudeDDegrees: 0), timePosted: nil, timeToPublish: nil, ethPrice: nil))
}
