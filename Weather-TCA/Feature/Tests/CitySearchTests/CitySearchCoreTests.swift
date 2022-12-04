import Combine
import ComposableArchitecture
import WeatherSDK
import XCTest
@testable import CitySearch

private extension Weather {
  static var mock: Self {
    .init(
      city: "Prague",
      weather: .clear,
      description: "Sunny",
      temperature: 22.2,
      pressure: 1000,
      humidity: 12.1
    )
  }
}

final class CitySearchCoreTests: XCTestCase {
  func test_sut_should_fech_weather_on_search_tap() {
    let weather = Weather.mock
    let testScheduler = DispatchQueue.test

    let sut = TestStore(
      initialState: CitySearchFeature.State(cityName: ""),
      reducer: CitySearchFeature()
    )

    sut.dependencies.mainQueue = testScheduler.eraseToAnyScheduler()
    sut.dependencies.weatherClient.fetchWeather = { _ in
      Just(weather)
        .setFailureType(to: WeatherError.self)
        .eraseToAnyPublisher()
    }

    sut.send(.searchTap)
    testScheduler.advance()
    sut.receive(.weatherLoadingState(.loading)) { state in
      state.weatherLoadingState = .loading
    }
    sut.receive(.weatherLoadingState(.loaded(weather))) { state in
      state.weatherLoadingState = .loaded(weather)
      state.cityDetail = .init(weather: weather)
    }
  }

  func test_sut_should_update_searched_city_name_on_new_value() {
    let sut = TestStore(
      initialState: CitySearchFeature.State(cityName: ""),
      reducer: CitySearchFeature()
    )

    sut.send(.nameChanged("P")) { state in
      state.cityName = "P"
    }
  }

  func test_sut_should_dismiss_city_detail_on_back_tap() {
    var state = CitySearchFeature.State(cityName: "")
    state.cityDetail = .init(weather: .mock)

    let sut = TestStore(
      initialState: state,
      reducer: CitySearchFeature()
    )

    sut.send(.cityDetail(.backTap))
    sut.receive(.setShowingCityDetail(false)) { state in
      state.cityDetail = nil
    }
  }
}
