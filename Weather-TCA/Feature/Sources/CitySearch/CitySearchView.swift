import CityDetail
import ComposableArchitecture
import CoreToolkit
import UIToolkit
import SwiftUI
import WeatherSDK

public extension CitySearchFeature {
  struct MainView: View {
    let store: StoreOf<CitySearchFeature>

    struct ViewState: Equatable {
      let loadingState: LoadingState<Weather, WeatherError>
      let isShowingDetail: Bool
      let searchQuery: String

      init(state: CitySearchFeature.State) {
        self.loadingState = state.weatherLoadingState
        self.searchQuery = state.cityName
        self.isShowingDetail = state.cityDetail != nil
      }
    }

    public init(store: StoreOf<CitySearchFeature>) {
      self.store = store
    }

    public var body: some View {
      WithViewStore(store.scope(state: ViewState.init(state:)), observe: { $0 }) { viewStore in
        switch viewStore.loadingState {
        case .loaded, .idle:
          NavigationView {
            VStack {
              HStack {
                TextField(
                  "Enter city name...",
                  text: viewStore.binding(
                    get: \.searchQuery,
                    send: CitySearchFeature.Action.nameChanged
                  )
                )
                .padding(10)
                .background(
                  LinearGradient(
                    gradient: Gradient(
                      colors: [
                        Color(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, opacity: 1)
                      ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                  )
                )
                .cornerRadius(20)

                Button(
                  action: { viewStore.send(.searchTap) },
                  label: { Image(systemName: "magnifyingglass") }
                )
              }

              Spacer()
            }
            .padding()
            .navigationTitle("Search weather")
            .background {
              NavigationLink(
                isActive: viewStore.binding(
                  get: \.isShowingDetail,
                  send: CitySearchFeature.Action.setShowingCityDetail
                ),
                destination: {
                  IfLetStore(self.store.scope(state: \.cityDetail, action: CitySearchFeature.Action.cityDetail)) {
                    CityDetailFeature.MainView(store: $0)
                  }
                },
                label: EmptyView.init
              )
            }
          }
        case .loading:
          LoadingView("Loading data")
        case .failed:
          ErrorView(
            action: { viewStore.send(.errorOkTap) },
            buttonLabel: "Understood"
          )
        }
      }
    }
  }
}

struct CitySearchMainView_Previews: PreviewProvider {
  static var previews: some View {
    CitySearchFeature.MainView(
      store: Store(
        initialState: .init(cityName: ""),
        reducer: CitySearchFeature(weatherClient: .dev)
      )
    )
  }
}


