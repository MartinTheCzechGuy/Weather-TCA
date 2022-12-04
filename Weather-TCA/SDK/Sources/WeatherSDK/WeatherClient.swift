import Combine

public struct WeatherClient {
  var fetchWeather: (String) -> AnyPublisher<Weather, WeatherError>
}

public extension WeatherClient {
  func fetchWeather(forCity city: String) -> AnyPublisher<Weather, WeatherError> {
    fetchWeather(city)
  }
}
