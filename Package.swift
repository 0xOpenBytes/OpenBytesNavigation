// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenBytesNavigation",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OpenBytesNavigation",
            targets: ["OpenBytesNavigation"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/0xOpenBytes/Disk", from: "0.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OpenBytesNavigation",
            dependencies: [
                "Disk"
            ]
        ),
        .testTarget(
            name: "OpenBytesNavigationTests",
            dependencies: ["OpenBytesNavigation"]
        )
    ]
)
