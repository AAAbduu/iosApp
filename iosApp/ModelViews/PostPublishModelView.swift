//
//  PostPublishModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/11/23.
//

import Foundation
import MapKit

class PostPublishModelView: ObservableObject{
    
    let model = ModelMain.shared
    
    
    func publishPost(postContent: String, graphicalResourceKey: String, whoClaimed: String, coordinates: CLLocationCoordinate2D , timePosted: Date, timeToPublish: Date){
        
        
        
        let geoGraphicalData : GeoGraphicalData = GeoGraphicalData(logitudeDDegrees: coordinates.animatableData.second, latitudeDDegrees: coordinates.animatableData.first)
        
        Task.detached {
            await self.model.createPost(postContent: postContent, graphicalResourceKey: graphicalResourceKey, whoClaimed: whoClaimed, geoGraphicaPostPos: geoGraphicalData, timePosted: timePosted, timeToPublish: timeToPublish)
        }
    }
    
}
