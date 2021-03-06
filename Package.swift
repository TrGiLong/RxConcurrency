// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxConcurrency",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),

    ],
    products: [
        .library(
            name: "RxConcurrency",
            targets: ["RxConcurrency"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "RxConcurrency",
            dependencies: ["RxSwift", .product(name: "RxCocoa", package: "RxSwift")]
        ),
        .testTarget(
            name: "RxConcurrencyTests",
            dependencies: ["RxConcurrency", .product(name: "RxBlocking", package: "RxSwift")]
        ),
    ]
)
