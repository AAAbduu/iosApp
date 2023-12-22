// swiftlint:disable all
import Amplify
import Foundation

extension Post {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case postOwner
    case postContent
    case postStatus
    case graphicalResourceKey
    case whoClaimed
    case geoGraphicalPostPosition
    case timePosted
    case timeToPublish
    case ethPrice
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let post = Post.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Posts"
    model.syncPluralName = "Posts"
    
    model.attributes(
      .index(fields: ["postOwnerId"], name: "owner"),
      .index(fields: ["whoClaimedId"], name: "claimed"),
      .primaryKey(fields: [post.id])
    )
    
    model.fields(
      .field(post.id, is: .required, ofType: .string),
      .belongsTo(post.postOwner, is: .required, ofType: User.self, targetNames: ["postOwnerId"]),
      .field(post.postContent, is: .required, ofType: .string),
      .field(post.postStatus, is: .optional, ofType: .enum(type: PostStatus.self)),
      .field(post.graphicalResourceKey, is: .optional, ofType: .string),
      .belongsTo(post.whoClaimed, is: .optional, ofType: User.self, targetNames: ["whoClaimedId"]),
      .field(post.geoGraphicalPostPosition, is: .required, ofType: .embedded(type: GeoGraphicalData.self)),
      .field(post.timePosted, is: .optional, ofType: .dateTime),
      .field(post.timeToPublish, is: .optional, ofType: .dateTime),
      .field(post.ethPrice, is: .optional, ofType: .double),
      .field(post.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(post.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Post: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}