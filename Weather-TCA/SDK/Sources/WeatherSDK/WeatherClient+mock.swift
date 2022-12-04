#if DEBUG
import Combine

extension WeatherClient {
  public static func mock(
    fetchWeather: @escaping (String) -> AnyPublisher<Weather, WeatherError> = { _ in fatalError("Unimplemented \(Self.self).fetchWeather") }
  ) ->  WeatherClient {
    .init(
      fetchWeather: fetchWeather
    )
  }
}
#endif
