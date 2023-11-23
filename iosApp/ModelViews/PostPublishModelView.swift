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
    
    func publishPost(graphicalResource: String, whoClaimed: String, coordinates: CLLocationCoordinate2D , timePosted: Date, timeToPublish: Date){
        
        
        
        let geoGraphicalData : GeoGraphicalData = GeoGraphicalData(longitudeDDegrees: coordinates.animatableData.first, latitudeDDegrees: coordinates.animatableData.second)
        
        Task.detached {
            await self.model.createPost( graphicalResource: graphicalResource, whoClaimed: whoClaimed, geoGraphicaPostPos: geoGraphicalData, timePosted: timePosted, timeToPublish: timeToPublish)
        }
    }
    
}
