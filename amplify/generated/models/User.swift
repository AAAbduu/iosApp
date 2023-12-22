// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var userAt: String
  public var userEmail: String?
  public var username: String?
  public var followingUsers: Int
  public var isContentCreator: Bool
  public var followingUsersAts: [String?]?
  public var followedUsers: Int
  public var followedUsersAts: [String?]?
  public var bioDescription: String?
  public var profileImageKey: String?
  public var bannerImageKey: String?
  public var claimedNFTs: List<Post>?
  public var posts: List<Post>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userAt: String,
      userEmail: String? = nil,
      username: String? = nil,
      followingUsers: Int,
      isContentCreator: Bool,
      followingUsersAts: [String?]? = nil,
      followedUsers: Int,
      followedUsersAts: [String?]? = nil,
      bioDescription: String? = nil,
      profileImageKey: String? = nil,
      bannerImageKey: String? = nil,
      claimedNFTs: List<Post>? = [],
      posts: List<Post>? = []) {
    self.init(id: id,
      userAt: userAt,
      userEmail: userEmail,
      username: username,
      followingUsers: followingUsers,
      isContentCreator: isContentCreator,
      followingUsersAts: followingUsersAts,
      followedUsers: followedUsers,
      followedUsersAts: followedUsersAts,
      bioDescription: bioDescription,
      profileImageKey: profileImageKey,
      bannerImageKey: bannerImageKey,
      claimedNFTs: claimedNFTs,
      posts: posts,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userAt: String,
      userEmail: String? = nil,
      username: String? = nil,
      followingUsers: Int,
      isContentCreator: Bool,
      followingUsersAts: [String?]? = nil,
      followedUsers: Int,
      followedUsersAts: [String?]? = nil,
      bioDescription: String? = nil,
      profileImageKey: String? = nil,
      bannerImageKey: String? = nil,
      claimedNFTs: List<Post>? = [],
      posts: List<Post>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userAt = userAt
      self.userEmail = userEmail
      self.username = username
      self.followingUsers = followingUsers
      self.isContentCreator = isContentCreator
      self.followingUsersAts = followingUsersAts
      self.followedUsers = followedUsers
      self.followedUsersAts = followedUsersAts
      self.bioDescription = bioDescription
      self.profileImageKey = profileImageKey
      self.bannerImageKey = bannerImageKey
      self.claimedNFTs = claimedNFTs
      self.posts = posts
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}