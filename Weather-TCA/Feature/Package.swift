// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "CityDetail",
      targets: ["CityDetail"]
    ),
    .library(
      name: "CitySearch",
      targets: ["CitySearch"]
    ),
  ],
  dependencies: [
    .package(path: "../Infrastructure"),
    .package(path: "../SDK"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.39.0")),
  ],
  targets: [
    .target(
      name: "CityDetail",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "WeatherSDK", package: "SDK"),
      ]
    ),
    .target(
      name: "CitySearch",
      dependencies: [
        "CityDetail",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "CoreToolkit", package: "Infrastructure"),
        .product(name: "UIToolkit", package: "Infrastructure"),
        .product(name: "WeatherSDK", package: "SDK"),
      ]
    ),
    .testTarget(
      name: "CitySearchTests",
      dependencies: ["CitySearch"]
    ),
  ]
)
