// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var postOwner: User
  public var postContent: String
  public var postStatus: PostStatus?
  public var graphicalResource: String?
  public var whoClaimed: String?
  public var geoGraphicalPostPosition: GeoGraphicalData?
  public var timePosted: Temporal.DateTime?
  public var timeToPublish: Temporal.DateTime?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      postOwner: User,
      postContent: String,
      postStatus: PostStatus? = nil,
      graphicalResource: String? = nil,
      whoClaimed: String? = nil,
      geoGraphicalPostPosition: GeoGraphicalData? = nil,
      timePosted: Temporal.DateTime? = nil,
      timeToPublish: Temporal.DateTime? = nil) {
    self.init(id: id,
      postOwner: postOwner,
      postContent: postContent,
      postStatus: postStatus,
      graphicalResource: graphicalResource,
      whoClaimed: whoClaimed,
      geoGraphicalPostPosition: geoGraphicalPostPosition,
      timePosted: timePosted,
      timeToPublish: timeToPublish,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      postOwner: User,
      postContent: String,
      postStatus: PostStatus? = nil,
      graphicalResource: String? = nil,
      whoClaimed: String? = nil,
      geoGraphicalPostPosition: GeoGraphicalData? = nil,
      timePosted: Temporal.DateTime? = nil,
      timeToPublish: Temporal.DateTime? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.postOwner = postOwner
      self.postContent = postContent
      self.postStatus = postStatus
      self.graphicalResource = graphicalResource
      self.whoClaimed = whoClaimed
      self.geoGraphicalPostPosition = geoGraphicalPostPosition
      self.timePosted = timePosted
      self.timeToPublish = timeToPublish
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}