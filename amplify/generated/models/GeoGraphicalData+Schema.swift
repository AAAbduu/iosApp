// swiftlint:disable all
import Amplify
import Foundation

extension GeoGraphicalData {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case longitudeDDegrees
    case latitudeDDegrees
    case region
    case city
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let geoGraphicalData = GeoGraphicalData.keys
    
    model.listPluralName = "GeoGraphicalData"
    model.syncPluralName = "GeoGraphicalData"
    
    model.fields(
      .field(geoGraphicalData.longitudeDDegrees, is: .optional, ofType: .double),
      .field(geoGraphicalData.latitudeDDegrees, is: .optional, ofType: .double),
      .field(geoGraphicalData.region, is: .optional, ofType: .string),
      .field(geoGraphicalData.city, is: .optional, ofType: .string)
    )
    }
}