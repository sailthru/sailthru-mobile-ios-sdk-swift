// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarigoldSwift",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MarigoldSwift",
            targets: ["MarigoldSwift"]),
    ],
    dependencies: [
        .package(name: "Marigold", url: "https://github.com/sailthru/sailthru-mobile-ios-sdk", .upToNextMajor(from: "15.0.0")),
    ],
    targets: [
        .target(
            name: "MarigoldSwift",
            dependencies: [
                .product(name: "Marigold", package: "Marigold", condition: .when(platforms: [.iOS])),
            ]),
        .testTarget(
            name: "MarigoldSwiftTests",
            dependencies: [
                "MarigoldSwift",
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
