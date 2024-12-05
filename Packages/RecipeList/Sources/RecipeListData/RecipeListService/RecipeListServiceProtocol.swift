//
//  RecipeListServiceProtocol.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

package import RecipeListCore

/// A service that handles the fetching of recipes.
package protocol RecipeListServiceProtocol: Sendable {

    /// Fetches and returns a list of recipes.
    func fetchRecipes() async throws -> [Recipe]
}
