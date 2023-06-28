// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "DI",
            targets: ["DI"]),
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Mocks",
            targets: ["Mocks"]),
        .library(
            name: "UserSearchDomain",
            targets: ["UserSearchDomain"]),
        .library(
            name: "UserSearchMVVM",
            targets: ["UserSearchMVVM"]),
        .library(
            name: "UserSearchMVVMC",
            targets: ["UserSearchMVVMC"]),
        .library(
            name: "UserSearchMVVMCUIKit",
            targets: ["UserSearchMVVMCUIKit"]),
        .library(
            name: "UserSearchTCA",
            targets: ["UserSearchTCA"]),
        .library(
            name: "UserSearchNetworkingCore",
            targets: ["UserSearchNetworkingCore"]),
        .library(
            name: "UserSearchNetworking",
            targets: ["UserSearchNetworking"]),
        .library(
            name: "Util",
            targets: ["Util"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject", exact: "2.8.3"),
        .package(url: "https://github.com/pointfreeco/combine-schedulers", exact: "0.10.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift", exact: "6.6.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage", exact: "5.16.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "0.54.1")
    ],
    targets: [
        .target(
            name: "DI",
            dependencies: [
                "Swinject"
            ]),

        .target(
            name: "Networking",
            dependencies: []),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),

        .target(
            name: "Mocks",
            dependencies: [
                "UserSearchDomain",
                "Util"
            ]),

        .target(
            name: "UserSearchDomain",
            dependencies: []),

        .target(
            name: "UserSearchMVVM",
            dependencies: [
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                "DI",
                "Networking",
                "UserSearchDomain",
                "UserSearchNetworking",
                "Util"
            ]),
        .testTarget(
            name: "UserSearchMVVMTests",
            dependencies: ["UserSearchMVVM", "Mocks"]),

        .target(
            name: "UserSearchMVVMC",
            dependencies: [
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
                "DI",
                "Networking",
                "UserSearchDomain",
                "UserSearchNetworking",
                "Util"
            ]),

        .target(
            name: "UserSearchMVVMCUIKit",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                "SDWebImage",
                "DI",
                "Networking",
                "UserSearchDomain",
                "UserSearchNetworking",
                "Util"
            ]),
        .testTarget(
            name: "UserSearchMVVMCUIKitTests",
            dependencies: [
                .product(name: "RxTest", package: "RxSwift"),
                "UserSearchMVVMCUIKit",
                "Mocks"
            ]),

        .target(
            name: "UserSearchTCA",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                "DI",
                "Networking",
                "UserSearchDomain",
                "UserSearchNetworking",
                "Util"
            ]),

        .target(
            name: "UserSearchNetworkingCore",
            dependencies: [
                "DI",
                "Networking",
                "Util"
            ]),

        .target(
            name: "UserSearchNetworking",
            dependencies: [
                "DI",
                "Networking",
                "UserSearchDomain",
                "UserSearchNetworkingCore",
                "Util"
            ]),

        .target(
            name: "Util",
            dependencies: []),
    ]
)
