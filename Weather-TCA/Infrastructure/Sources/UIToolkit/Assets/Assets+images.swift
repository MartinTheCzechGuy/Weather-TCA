import SwiftUI

public struct Assets: Equatable {
  private let name: String
}

public extension Assets {
  enum Images {
    public static let clear = Image("clear", bundle: .module)
    public static let clouds = Image("clouds", bundle: .module)
    public static let drizzle = Image("drizzle", bundle: .module)
    public static let error = Image("error", bundle: .module)
    public static let mist = Image("mist", bundle: .module)
    public static let rain = Image("rain", bundle: .module)
    public static let snow = Image("snow", bundle: .module)
    public static let thunderstorm = Image("thunderstorm", bundle: .module)
  }
}
