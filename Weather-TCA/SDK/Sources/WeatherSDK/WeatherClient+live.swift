import Combine
import Foundation

private struct WeatherDTO: Decodable {
  let name: String
  let weather: [WeatherDescriptionDTO]
  let main: WeatherDataDTO

  struct WeatherDescriptionDTO: Decodable {
    let id: Int
    let main: String
    let description: String
  }

  struct WeatherDataDTO: Decodable {
    let temp: Double
    let pressure: Double
    let humidity: Double
  }
}

extension WeatherClient {
  public static func live() -> WeatherClient {
    .init(
      fetchWeather: { city in
        currentWeatherComponents(for: city)
          .publisher
          .flatMap {
            URLSession.shared.dataTaskPublisher(for: $0)
              .mapError { error -> WeatherError in
                if error.errorCode == 404 {
                  return WeatherError.cityNotFound
                }

                return WeatherError.networkingError(error)
              }
          }
          .map(\.data)
          .flatMap { data in
            Just(data)
              .decode(type: WeatherDTO.self, decoder: JSONDecoder())
              .mapError { _ in WeatherError.decodingError }
          }
          .map { dto in
            var weatherCode: WeatherCode
            switch dto.weather.first!.id {
            case 200..<300: weatherCode = .thunderstorm
            case 300..<400: weatherCode = .drizzle
            case 500..<600: weatherCode = .rain
            case 600..<700: weatherCode = .snow
            case 700..<800: weatherCode = .mist
            case 801..<900: weatherCode = .clouds
            default:
              weatherCode = .clear
            }

            return Weather(
              city: dto.name,
              weather: weatherCode,
              description: dto.weather.first?.description ?? "No weather description.",
              temperature: dto.main.temp,
              pressure: dto.main.pressure,
              humidity: dto.main.humidity
            )
          }
          .eraseToAnyPublisher()
      }
    )
  }

  private static func currentWeatherComponents(for city: String) -> Result<URL, WeatherError> {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.openweathermap.org"
    components.path = "/data/2.5/weather"

    components.queryItems = [
      URLQueryItem(name: "q", value: city),
      URLQueryItem(name: "mode", value: "json"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "APPID", value: "599304f5bdc844899dec31a799dd6761")
    ]

    guard let url = components.url else {
      return .failure(.buildingRequestFailure)
    }

    return .success(url)
  }
}
