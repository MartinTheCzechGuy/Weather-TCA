import Combine

extension WeatherClient {
  public static func mock(
    fetchWeather: @escaping (String) -> AnyPublisher<Weather, WeatherError>
  ) ->  WeatherClient {
    .init(
      fetchWeather: { _ in fatalError("Unimplemented \(Self.self).fetchWeather") }
    )
  }
}
