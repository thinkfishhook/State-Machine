// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FHK State Machine",
    platforms: [ .iOS(.v10), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3) ],
    products: [
        .library(
            name: "State Machine",
            type: .static,
            targets: [ "StateMachine" ]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can
        // define a module or a test suite.
        // Targets can depend on other targets in this package, and on products
        // in packages this package depends on.
        .target(
            name: "StateMachine",
            dependencies: []),
        .testTarget(
            name: "StateMachineTests",
            dependencies: [ "StateMachine" ]),
    ],
    swiftLanguageVersions: [ .v5 ]
)
