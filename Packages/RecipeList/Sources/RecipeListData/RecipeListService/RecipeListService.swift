//
//  RecipeListService.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/4/24.
//

package import HTTPClient
package import RecipeListCore

/// A service that handles the fetching of recipes.
package struct RecipeListService: RecipeListServiceProtocol {

    // MARK: Properties

    /// The HTTP client to use for fetching.
    let httpClient: any HTTPClientProtocol

    // MARK: Initializer

    package init(httpClient: any HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: Functions

    /// Fetches and returns a list of recipes.
    package func fetchRecipes() async throws -> [Recipe] {
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        let recipesDTO: RecipesDTO = try await httpClient.get(endpoint: endpoint)
        return recipesDTO.recipes
    }
}
