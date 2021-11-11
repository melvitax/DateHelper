// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DateHelper",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "DateHelper",
            targets: ["DateHelper"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DateHelper",
            dependencies: []),
        .testTarget(
            name: "DateHelperTests",
            dependencies: ["DateHelper"]),
    ],
    swiftLanguageVersions: [.v5]
)
