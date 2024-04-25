// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TmdbCore",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TmdbCore",
            targets: ["TmdbCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/kean/Nuke", from: Version("12.6.0")),
        .package(url: "https://github.com/realm/realm-swift.git", from: Version("10.47.0")),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", from: Version("9.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TmdbCore",
            dependencies: [
                .product(name: "NukeUI", package: "Nuke"),
                .product(name: "Realm", package: "realm-swift"),
                .product(name: "RealmSwift", package: "realm-swift"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "TmdbCoreTests",
            dependencies: ["TmdbCore",
                           .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ],
            resources: [
                .process("Resources")
            ]),
    ]
)
