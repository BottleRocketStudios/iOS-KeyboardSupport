// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "KeyboardSupport",
    platforms: [
        .macOS("10.12"),
        .iOS("10.0"),
        .tvOS("10.0"),
        .watchOS("4.2")
    ],
    products: [
        .library(
            name: "KeyboardSupport",
            targets: ["KeyboardSupport"])
    ],
    targets: [
        .target(
            name: "KeyboardSupport",
            path: "Sources"),
        .testTarget(
            name: "KeyboardSupport-iOSTests",
            dependencies: ["KeyboardSupport"],
            path: "Tests")
    ]
)
