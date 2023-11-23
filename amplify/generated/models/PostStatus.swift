// swiftlint:disable all
import Amplify
import Foundation

public enum PostStatus: String, EnumPersistable {
  case past = "PAST"
  case live = "LIVE"
  case upcoming = "UPCOMING"
}