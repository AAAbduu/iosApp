// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var postOwner: User
  public var postContent: String
  public var postStatus: PostStatus?
  public var graphicalResourceKey: String?
  public var whoClaimed: User?
  public var geoGraphicalPostPosition: GeoGraphicalData
  public var timePosted: Temporal.DateTime?
  public var timeToPublish: Temporal.DateTime?
  public var ethPrice: Double?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      postOwner: User,
      postContent: String,
      postStatus: PostStatus? = nil,
      graphicalResourceKey: String? = nil,
      whoClaimed: User? = nil,
      geoGraphicalPostPosition: GeoGraphicalData,
      timePosted: Temporal.DateTime? = nil,
      timeToPublish: Temporal.DateTime? = nil,
      ethPrice: Double? = nil) {
    self.init(id: id,
      postOwner: postOwner,
      postContent: postContent,
      postStatus: postStatus,
      graphicalResourceKey: graphicalResourceKey,
      whoClaimed: whoClaimed,
      geoGraphicalPostPosition: geoGraphicalPostPosition,
      timePosted: timePosted,
      timeToPublish: timeToPublish,
      ethPrice: ethPrice,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      postOwner: User,
      postContent: String,
      postStatus: PostStatus? = nil,
      graphicalResourceKey: String? = nil,
      whoClaimed: User? = nil,
      geoGraphicalPostPosition: GeoGraphicalData,
      timePosted: Temporal.DateTime? = nil,
      timeToPublish: Temporal.DateTime? = nil,
      ethPrice: Double? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.postOwner = postOwner
      self.postContent = postContent
      self.postStatus = postStatus
      self.graphicalResourceKey = graphicalResourceKey
      self.whoClaimed = whoClaimed
      self.geoGraphicalPostPosition = geoGraphicalPostPosition
      self.timePosted = timePosted
      self.timeToPublish = timeToPublish
      self.ethPrice = ethPrice
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}