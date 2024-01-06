//
//  PostPublishModelView.swift
//  iosApp
//
//  Created by Abdurrahim Ali on 23/11/23.
//

/**
 A view model class for publishing posts within the app.

 This class is responsible for handling the process of publishing new posts, including creating and uploading post content.

 - Important:
    - This class is an `ObservableObject`, making it suitable for use in SwiftUI views.
*/

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
