// swiftlint:disable all
import Amplify
import Foundation

public struct GeoGraphicalData: Embeddable {
  var longitudeDDegrees: Double?
  var latitudeDDegrees: Double?
  var region: String?
  var city: String?
}