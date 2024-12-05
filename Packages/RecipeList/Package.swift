// swift-tools-version: 6.0

@preconcurrency import PackageDescription

// MARK: - Package

let package = Package(
    name: "RecipeList",
    platforms: [.iOS(.v18)],
    products: [
        .library(for: .recipeListCore),
        .library(for: .recipeListData),
        .library(for: .recipeListView)
    ],
    dependencies: [
        .appFoundation
    ],
    targets: [
        .recipeListCore,
        .recipeListData,
        .recipeListView,
        .unitTests(for: .recipeListData),
        .unitTests(for: .recipeListView)
    ]
)

// MARK: - Targets

extension Target {
    
    static let recipeListCore: Target = .target(
        name: "RecipeListCore",
        dependencies: [],
        swiftSettings: .upcomingFeatures
    )
    
    static let recipeListData: Target = .target(
        name: "RecipeListData",
        dependencies: [
            .dependency(on: .recipeListCore),
            .httpClient
        ],
        swiftSettings: .upcomingFeatures
    )

    static let recipeListView: Target = .target(
        name: "RecipeListView",
        dependencies: [
            .dependency(on: .recipeListCore),
            .dependency(on: .recipeListData),
            .appFoundation,
            .cachingImage,
            .httpClient
        ],
        swiftSettings: .upcomingFeatures
    )
}

// MARK: - Target Dependencies

extension Target.Dependency {

    // MARK: AppFoundation Targets

    static let appFoundation: Target.Dependency = .product(
        name: "AppFoundation",
        package: "AppFoundation"
    )

    static let cachingImage: Target.Dependency = .product(
        name: "CachingImage",
        package: "AppFoundation"
    )
    
    static let httpClient: Target.Dependency = .product(
        name: "HTTPClient",
        package: "AppFoundation"
    )
}

// MARK: - Package Dependencies

extension Package.Dependency {

    static let appFoundation: Package.Dependency = .package(
        name: "AppFoundation",
        path: "./AppFoundation"
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
