// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WhatToWearCommonCore",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_14)
    ],
    products: [
        .library(name: "WhatToWearCommonCore", targets: ["WhatToWearCommonCore"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "WhatToWearCommonCore", path: "WhatToWearCommonCore"),
    ]
)
