import Foundation

public struct Weather: Equatable {
  public let city: String
  public let weather: WeatherCode
  public let description: String
  public let temperature: Double
  public let pressure: Double
  public let humidity: Double

  public init(city: String, weather: WeatherCode, description: String, temperature: Double, pressure: Double, humidity: Double) {
    self.city = city
    self.weather = weather
    self.description = description
    self.temperature = temperature
    self.pressure = pressure
    self.humidity = humidity
  }
}
