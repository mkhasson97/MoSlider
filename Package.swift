// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoSlider",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "MoSlider",
            targets: ["MoSlider"])
    ],
    targets: [
        .target(
            name: "MoSlider",
            dependencies: [])
    ]
)
