// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "KeyboardSupport",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "KeyboardSupport", targets: ["KeyboardSupport"])
    ],
    targets: [
        .target(name: "KeyboardSupport", path: "Sources"),
        .testTarget(name: "KeyboardSupportTests", dependencies: ["KeyboardSupport"], path: "Tests")
    ]
)
