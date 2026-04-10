// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "RTKNegativeTest",
    products: [
        .library(name: "RTKNegativeLib", targets: ["RTKNegativeLib"]),
    ],
    targets: [
        .target(name: "RTKNegativeLib"),
        .testTarget(
            name: "RTKNegativeLibTests",
            dependencies: ["RTKNegativeLib"]
        ),
    ]
)
