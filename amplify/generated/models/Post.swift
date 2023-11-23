// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var userID: String?
  public var postStatus: PostStatus?
  public var graphicalResource: String?
  public var whoClaimedUN: String?
  public var geographicalPostPosition: GeoGraphicalData?
  public var timePosted: Temporal.DateTime?
  public var timeToPublish: Temporal.DateTime?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userID: String? = nil,
      postStatus: PostStatus? = nil,
      graphicalResource: String? = nil,
      whoClaimedUN: String? = nil,
      geographicalPostPosition: GeoGraphicalData? = nil,
      timePosted: Temporal.DateTime? = nil,
      timeToPublish: Temporal.DateTime? = nil) {
    self.init(id: id,
      userID: userID,
      postStatus: postStatus,
      graphicalResource: graphicalResource,
      whoClaimedUN: whoClaimedUN,
      geographicalPostPosition: geographicalPostPosition,
      timePosted: timePosted,
      timeToPublish: timeToPublish,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userID: String? = nil,
      postStatus: PostStatus? = nil,
      graphicalResource: String? = nil,
      whoClaimedUN: String? = nil,
      geographicalPostPosition: GeoGraphicalData? = nil,
      timePosted: Temporal.DateTime? = nil,
      timeToPublish: Temporal.DateTime? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userID = userID
      self.postStatus = postStatus
      self.graphicalResource = graphicalResource
      self.whoClaimedUN = whoClaimedUN
      self.geographicalPostPosition = geographicalPostPosition
      self.timePosted = timePosted
      self.timeToPublish = timeToPublish
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}