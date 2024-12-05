// swift-tools-version: 6.0

@preconcurrency import PackageDescription

// MARK: - Package

let package = Package(
    name: "AppFoundation",
    platforms: [.iOS(.v18)],
    products: [
        .library(for: .appFoundation),
        .library(for: .cachingImage),
        .library(for: .httpClient)
    ],
    dependencies: [
    ],
    targets: [
        .appFoundation,
        .cachingImage,
        .httpClient,
        .unitTests(for: .cachingImage),
        .unitTests(for: .httpClient)
    ]
)

// MARK: - Targets

extension Target {

    static let appFoundation: Target = .target(
        name: "AppFoundation",
        dependencies: [],
        swiftSettings: .upcomingFeatures
    )
    
    static let cachingImage: Target = .target(
        name: "CachingImage",
        dependencies: [],
        swiftSettings: .upcomingFeatures
    )
    
    static let httpClient: Target = .target(
        name: "HTTPClient",
        dependencies: [],
        swiftSettings: .upcomingFeatures
    )
}


// MARK: - Swift Settings

extension [SwiftSetting] {

    static let upcomingFeatures: [SwiftSetting] = [
        .existentialAny,
        .internalImportsByDefault
    ]
}

extension SwiftSetting {

    static let existentialAny: SwiftSetting = .enableUpcomingFeature("ExistentialAny")
    
    static let internalImportsByDefault: SwiftSetting = .enableUpcomingFeature("InternalImportsByDefault")
}

// MARK: - Helpers

extension Product {

    // MARK: Library

    static func library(
        for target: Target,
        type: Library.LibraryType? = nil
    ) -> Product {
        .library(
            name: target.name,
            type: type,
            targets: [target.name]
        )
    }
}

extension Target {

    // MARK: Unit Tests

    static func unitTests(
        for target: Target,
        additionalDependencies: [Target.Dependency] = [],
        resources: [Resource] = []
    ) -> Target {
        .testTarget(
            name: "\(target.name)Tests",
            dependencies: [.dependency(on: target)] + additionalDependencies,
            resources: resources,
            swiftSettings: .upcomingFeatures
        )
    }
}

extension Target.Dependency {

    // MARK: Dependency

    static func dependency(on target: Target) -> Target.Dependency {
        .target(name: target.name)
    }
}
