import ComposableArchitecture
import WeatherSDK

public struct CityDetailFeature: ReducerProtocol {

  public init() {}

  public struct State: Equatable {
    let weather: Weather

    public init(weather: Weather) {
      self.weather = weather
    }
  }

  public enum Action: Equatable {
    case backTap
  }

  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    return .none
  }
}
