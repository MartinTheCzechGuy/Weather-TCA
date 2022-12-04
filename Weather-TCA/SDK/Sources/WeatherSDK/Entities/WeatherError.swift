import Foundation

public enum WeatherError: Error, Equatable {
  case cityNotFound
  case buildingRequestFailure
  case decodingError
  case networkingError(Error)

  public static func == (lhs: WeatherError, rhs: WeatherError) -> Bool {
    switch (lhs, rhs) {
    case (.cityNotFound, .cityNotFound),
      (.buildingRequestFailure, .buildingRequestFailure),
      (.decodingError, .decodingError),
      (.networkingError, .networkingError):
      return true
    default:
      return false
    }
  }
}
