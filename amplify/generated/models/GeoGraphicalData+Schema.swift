// swiftlint:disable all
import Amplify
import Foundation

extension GeoGraphicalData {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case logitudeDDegrees
    case latitudeDDegrees
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let geoGraphicalData = GeoGraphicalData.keys
    
    model.listPluralName = "GeoGraphicalData"
    model.syncPluralName = "GeoGraphicalData"
    
    model.fields(
      .field(geoGraphicalData.logitudeDDegrees, is: .optional, ofType: .double),
      .field(geoGraphicalData.latitudeDDegrees, is: .optional, ofType: .double)
    )
    }
}