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
    case graphicalResource
    case whoClaimed
    case geoGraphicalPostPosition
    case timePosted
    case timeToPublish
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
      .primaryKey(fields: [post.id])
    )
    
    model.fields(
      .field(post.id, is: .required, ofType: .string),
      .belongsTo(post.postOwner, is: .required, ofType: User.self, targetNames: ["userPostsId"]),
      .field(post.postContent, is: .required, ofType: .string),
      .field(post.postStatus, is: .optional, ofType: .enum(type: PostStatus.self)),
      .field(post.graphicalResource, is: .optional, ofType: .string),
      .field(post.whoClaimed, is: .optional, ofType: .string),
      .field(post.geoGraphicalPostPosition, is: .optional, ofType: .embedded(type: GeoGraphicalData.self)),
      .field(post.timePosted, is: .optional, ofType: .dateTime),
      .field(post.timeToPublish, is: .optional, ofType: .dateTime),
      .field(post.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(post.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Post: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}