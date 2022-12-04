import ComposableArchitecture
import SwiftUI
import WeatherSDK

public extension CityDetailFeature {
  struct MainView: View {

    let store: StoreOf<CityDetailFeature>

    public init(store: StoreOf<CityDetailFeature>) {
      self.store = store
    }

    struct ViewState: Equatable {
      let weatherCode: WeatherCode
      let description: String
      let temperature: String
      let pressure: String
      let humidity: String
      let city: String

      init(state: CityDetailFeature.State) {
        self.weatherCode = state.weather.weather
        self.description = state.weather.description
        self.city = state.weather.city

        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit

        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        formatter.numberFormatter = numberFormatter

        let temperatureMeasurement = Measurement(
          value: state.weather.temperature,
          unit: UnitTemperature.celsius
        )

        let pressureMeasurement = Measurement(
          value: state.weather.pressure,
          unit: UnitPressure.hectopascals
        )
        self.temperature = formatter.string(from: temperatureMeasurement)
        self.pressure = formatter.string(from: pressureMeasurement)
        self.humidity = String(format: "%.1f", state.weather.humidity)
      }
    }

    public var body: some View {
      WithViewStore(store.scope(state: ViewState.init(state:)), observe: { $0 }) { viewStore in
        ZStack {
          viewStore.weatherCode.background
            .ignoresSafeArea()

          VStack(
            alignment: .center,
            spacing: 20
          ) {
            Text("Current weather in \(viewStore.city)")
              .font(.title)

            Text(viewStore.description)
              .font(.title2)

            Spacer()

            Image(viewStore.weatherCode.icon)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 150, height: 150)

            Spacer()

            VStack(spacing: 10) {
              Text("🌡 Temperature is \(viewStore.temperature)")
              Text("Pressure is \(viewStore.pressure)")
              Text("💧 Humidity is \(viewStore.humidity) %")
            }
            .font(.title3)
            .foregroundColor(viewStore.weatherCode.fontColor)

            Spacer()
          }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(
              action: { viewStore.send(.backTap) },
              label: {
                Image(systemName: "xmark")
                  .imageScale(.large)
                  .foregroundColor(viewStore.weatherCode.fontColor)
              }
            )
          }
        }
      }
    }
  }
}

struct CityDetailMainView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CityDetailFeature.MainView(
        store: Store(
          initialState: .init(
            weather: .init(
              city: "Prague",
              weather: .clear,
              description: "Sunny",
              temperature: 22.2,
              pressure: 1000,
              humidity: 12.1
            )
          ),
          reducer: CityDetailFeature()
        )
      )
    }
  }
}

