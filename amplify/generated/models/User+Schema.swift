// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case userAt
    case userEmail
    case username
    case followingUsers
    case isContentCreator
    case followingUsersAts
    case followedUsers
    case followedUsersAts
    case bioDescription
    case profileImageKey
    case bannerImageKey
    case claimedNFTs
    case posts
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let user = User.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Users"
    model.syncPluralName = "Users"
    
    model.attributes(
      .index(fields: ["userAt"], name: "userByUserAt"),
      .primaryKey(fields: [user.id])
    )
    
    model.fields(
      .field(user.id, is: .required, ofType: .string),
      .field(user.userAt, is: .required, ofType: .string),
      .field(user.userEmail, is: .optional, ofType: .string),
      .field(user.username, is: .optional, ofType: .string),
      .field(user.followingUsers, is: .required, ofType: .int),
      .field(user.isContentCreator, is: .required, ofType: .bool),
      .field(user.followingUsersAts, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(user.followedUsers, is: .required, ofType: .int),
      .field(user.followedUsersAts, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(user.bioDescription, is: .optional, ofType: .string),
      .field(user.profileImageKey, is: .optional, ofType: .string),
      .field(user.bannerImageKey, is: .optional, ofType: .string),
      .hasMany(user.claimedNFTs, is: .optional, ofType: Post.self, associatedWith: Post.keys.whoClaimed),
      .hasMany(user.posts, is: .optional, ofType: Post.self, associatedWith: Post.keys.postOwner),
      .field(user.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(user.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension User: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}