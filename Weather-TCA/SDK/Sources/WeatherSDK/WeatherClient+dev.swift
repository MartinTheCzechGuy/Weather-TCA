import Combine

extension WeatherClient {
  public static var dev: WeatherClient {
    .init(
      fetchWeather: { _ in
        Just(
          Weather(
            city: "Prague",
            weather: .clear,
            description: "Sunny",
            temperature: 22.2,
            pressure: 1000,
            humidity: 12.1
          )
        )
        .setFailureType(to: WeatherError.self)
        .eraseToAnyPublisher()
      }
    )
  }
}
