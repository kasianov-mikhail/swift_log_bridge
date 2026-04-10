// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift_log_bridge",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "swift-log-bridge", targets: ["swift_log_bridge"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "swift_log_bridge",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ]
        )
    ]
)
