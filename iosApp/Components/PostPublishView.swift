//
//  PostPublishView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 14/11/23.
//

/**
 A view for publishing a new post.

 This view includes UI elements for entering post details such as description, URL, location, and date.
 */

import SwiftUI
import MapKit
import SceneKit



struct PostPublishView: View {
    @StateObject private var vM = PostPublishModelView()
    
    @State private var postDescription = ""
    @State private var postURL = "https://www.hogent.be"
    @State private var longitude = ""
    @State private var latitude = ""
    @State private var ethPrice = ""
    @State private var coordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State private var showMarker = false
    @State private var cameraPosition: MapCameraPosition = .automatic

    
    @Binding var show: Bool
    @State private var selectedDate: Date = Date()
    
    init(show: Binding<Bool>) {
            self._show = show
        }
    
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Button(action: {
                        withAnimation(){
                            show = false
                        }
                    }){
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    .padding([.top, .leading])
                    Spacer()
                    Button(action: {
                        withAnimation(){
                            show = false
                        }
                        vM.publishPost(postContent: postDescription, graphicalResourceKey: postURL, whoClaimed: "", coordinates: coordinates , timePosted: Date(), timeToPublish: selectedDate)
                    }){
                        Text("Publish")
                            .fontWeight(.bold)
                            .frame(width: 80, height: 40)
                            .foregroundColor(.black)
                            .background(Color.purple)
                            .clipShape(Capsule())
                    }
                    .padding([.top, .trailing])
                }
                HStack(alignment: .top){
                    Circle()
                        .padding(.leading, 5.0)
                        .frame(width: 50)
                    Spacer()
                    CustomTextEditorView(text: $postDescription, placeholder: "Ready to connect WEB3")
                        .padding(.trailing, 20.0)
                        .frame(height: 150.0)
                }
                .padding(.trailing)
                
                HStack{
                    Spacer()
                    Text("\(postDescription.count) / 140")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.trailing)
                }
                .frame(height: 20)
                .background(Color.purple)
                
                Text("This feature will be added soon!")
                
                InputField(text: $postURL, image: "globe", placeHolder: "", isSecureField: false)
                    .padding(.vertical)
                    .textInputAutocapitalization(.never)
                    .disabled(true)
                
                Button("Reach resource") {
                    // Cargar el recurso aquí...
                }
                .disabled(true)
                
                // Vista de SceneKit para mostrar el modelo 3D
                //SceneView()
                  //  .frame(height: 200)
                
                Text("Your resource will be displayed here when the feature is added!")
                    .font(.caption)
                    .padding()
                    
                
                Text("Where would you like to have your NFT available?")
                
                InputField(text: $latitude, image: "mappin", placeHolder: "Latitude", isSecureField: false)
                    .padding(.vertical)
                
                InputField(text: $longitude, image: "mappin", placeHolder: "Longitude", isSecureField: false)
                    .padding(.bottom)
                
                Button("Locate on map") {
                    if let lat = Double(latitude), let lon = Double(longitude) {
                        self.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        self.showMarker = true
                    }
                }
                
                Map(position: $cameraPosition){
                    self.showMarker ? Marker("NFT", coordinate: self.coordinates) : nil
                }
                .frame(height: 200)
                .mapStyle(.standard(elevation: .realistic))
                .mapControls {
                    MapUserLocationButton()
                }
                .onChange(of: self.coordinates.animatableData) { _ , _ in
                    cameraPosition = .automatic
                }
                
                Text("When would you like to have your NFT available?")
                
                DatePicker("Select a date", selection: $selectedDate, in: Date()...)
                    .padding(.horizontal)
                    .datePickerStyle(CompactDatePickerStyle())
                    .frame(maxHeight: 400)
                Text("How much should the NFT cost?")
                
                InputField(text: $ethPrice, image: "envelope", placeHolder: "ETH", isSecureField: false)
                    .padding(.bottom)
                    .frame(width: 200)
                    .disabled(true)
                Text("This feature will arrive soon, meanwhile all nfts will be posted for free!")
                    .font(.caption)
                
                Spacer()
                
            }
            .background(Color.white)
        }
    }
    
}

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

/*struct SceneView: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene(named: "animacionO.dae") // Cambia "tuModelo.dae" por el nombre de tu archivo
        sceneView.autoenablesDefaultLighting = true // Para agregar iluminación básica
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}
}*/


#Preview {
    PostPublishView(show: .constant(false))
}

