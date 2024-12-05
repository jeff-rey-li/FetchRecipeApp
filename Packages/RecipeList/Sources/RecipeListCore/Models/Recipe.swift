//
//  Recipe.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

package import Foundation

/// A cooking recipe.
package struct Recipe: Identifiable, Equatable {

    // MARK: Properties

    package let id: UUID

    /// The type of cuisine.
    package let cuisine: String

    /// The name of the recipe.
    package let name: String

    /// The URL associated with the large image of the recipe.
    package let photoUrlLarge: String?

    /// The URL associated with the small image of the recipe.
    package let photoUrlSmall: String?

    /// The source URL of the recipe.
    package let sourceUrl: String?

    /// The URL of a youtube video of the recipe.
    package let youtubeUrl: String?

    // MARK: Intitializer

    package init(cuisine: String, name: String) {
        self.id = UUID()
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = nil
        self.photoUrlSmall = nil
        self.sourceUrl = nil
        self.youtubeUrl = nil
    }

    // MARK: CodingKeys

    package enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

// MARK: - Decodable

extension Recipe: Decodable {

    package init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoUrlLarge = try container.decodeIfPresent(String.self, forKey: .photoUrlLarge)
        self.photoUrlSmall = try container.decodeIfPresent(String.self, forKey: .photoUrlSmall)
        self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        self.youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl)
    }
}
