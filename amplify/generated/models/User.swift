// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var username: String?
  public var userAt: String?
  public var isContentCreator: Bool?
  public var bioDescription: String?
  public var userEmail: String?
  public var followingUsers: Int?
  public var usersFollowed: Int?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      username: String? = nil,
      userAt: String? = nil,
      isContentCreator: Bool? = nil,
      bioDescription: String? = nil,
      userEmail: String? = nil,
      followingUsers: Int? = nil,
      usersFollowed: Int? = nil) {
    self.init(id: id,
      username: username,
      userAt: userAt,
      isContentCreator: isContentCreator,
      bioDescription: bioDescription,
      userEmail: userEmail,
      followingUsers: followingUsers,
      usersFollowed: usersFollowed,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      username: String? = nil,
      userAt: String? = nil,
      isContentCreator: Bool? = nil,
      bioDescription: String? = nil,
      userEmail: String? = nil,
      followingUsers: Int? = nil,
      usersFollowed: Int? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.username = username
      self.userAt = userAt
      self.isContentCreator = isContentCreator
      self.bioDescription = bioDescription
      self.userEmail = userEmail
      self.followingUsers = followingUsers
      self.usersFollowed = usersFollowed
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}