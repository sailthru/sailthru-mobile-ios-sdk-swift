// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SailthruMobileSwift",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SailthruMobileSwift",
            targets: ["SailthruMobileSwift"]),
    ],
    dependencies: [
        .package(name: "SailthruMobile", url: "https://github.com/sailthru/sailthru-mobile-ios-sdk", .upToNextMajor(from: "14.0.0")),
    ],
    targets: [
        .target(
            name: "SailthruMobileSwift",
            dependencies: [
                .product(name: "SailthruMobile", package: "SailthruMobile", condition: .when(platforms: [.iOS])),
            ]),
        .testTarget(
            name: "SailthruMobileSwiftTests",
            dependencies: [
                "SailthruMobileSwift",
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
