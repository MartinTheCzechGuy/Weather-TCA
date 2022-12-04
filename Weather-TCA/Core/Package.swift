// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "Root",
      targets: ["Root"]
    ),
  ],
  dependencies: [
    .package(path: "../Feature"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.39.0")),
  ],
  targets: [
    .target(
      name: "Root",
      dependencies: [
        .product(name: "CitySearch", package: "Feature"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
  ]
)
