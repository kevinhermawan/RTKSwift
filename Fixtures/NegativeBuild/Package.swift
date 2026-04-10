// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "RTKNegativeBuild",
    products: [
        .library(name: "RTKNegativeBuild", targets: ["RTKNegativeBuild"]),
    ],
    targets: [
        .target(name: "RTKNegativeBuild"),
    ]
)
