import CityDetail
import ComposableArchitecture
import CoreToolkit
import WeatherSDK

public struct CitySearchFeature: ReducerProtocol {
  public struct State: Equatable {
    var cityName: String
    var weatherLoadingState: LoadingState<Weather, WeatherError>
    var cityDetail: CityDetailFeature.State?

    public init(cityName: String) {
      self.cityName = cityName
      self.weatherLoadingState = .idle
    }
  }

  public enum Action: Equatable {
    case nameChanged(String)
    case searchTap
    case cityDetail(CityDetailFeature.Action)
    case weatherLoadingState(LoadingState<Weather, WeatherError>)
    case setShowingCityDetail(Bool)
    case errorOkTap
  }

  @Dependency(\.mainQueue) var mainQueue
  private let weatherClient: WeatherClient

  public init(weatherClient: WeatherClient) {
    self.weatherClient = weatherClient
  }

  private enum FetchWeatherID {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .nameChanged(newValue):
        state.cityName = newValue
        return .none

      case .searchTap:
        return weatherClient.fetchWeather(forCity: state.cityName)
          .loadingPublisher()
          .receive(on: mainQueue)
          .eraseToEffect(CitySearchFeature.Action.weatherLoadingState)
          .cancellable(id: FetchWeatherID.self, cancelInFlight: true)

      case let .weatherLoadingState(newState):
        state.weatherLoadingState = newState

        if case let .loaded(cityWeather) = newState {
          state.cityDetail = .init(weather: cityWeather)
        }

        return .none

      case let .setShowingCityDetail(isShowing):
        if !isShowing {
          state.cityDetail = nil
        }

        return .none

      case .cityDetail(.backTap):
        state.cityName = ""
        state.weatherLoadingState = .idle
        return Effect(value: .setShowingCityDetail(false))

      case .errorOkTap:
        state.weatherLoadingState = .idle
        return .none
      }
    }
    .ifLet(\CitySearchFeature.State.cityDetail, action: /CitySearchFeature.Action.cityDetail) {
      CityDetailFeature()
    }
  }
}
