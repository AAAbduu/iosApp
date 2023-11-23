// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case username
    case userAt
    case isContentCreator
    case bioDescription
    case userEmail
    case followingUsers
    case usersFollowed
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
      .primaryKey(fields: [user.id])
    )
    
    model.fields(
      .field(user.id, is: .required, ofType: .string),
      .field(user.username, is: .optional, ofType: .string),
      .field(user.userAt, is: .optional, ofType: .string),
      .field(user.isContentCreator, is: .optional, ofType: .bool),
      .field(user.bioDescription, is: .optional, ofType: .string),
      .field(user.userEmail, is: .optional, ofType: .string),
      .field(user.followingUsers, is: .optional, ofType: .int),
      .field(user.usersFollowed, is: .optional, ofType: .int),
      .field(user.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(user.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension User: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}