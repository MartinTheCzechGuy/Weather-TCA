import CitySearch
import ComposableArchitecture
import SwiftUI

public struct RootView: View {

  public init() {}

  public var body: some View {
    CitySearchFeature.MainView(
      store: Store(
        initialState: CitySearchFeature.State(cityName: ""),
        reducer: CitySearchFeature(
          weatherClient: .live()
        )
      )
    )
  }
}
