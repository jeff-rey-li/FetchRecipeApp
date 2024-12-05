//
//  RecipeListRepositoryProtocol.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

package import RecipeListCore

/// A repository that manages fetching recipes.
package protocol RecipeListRepositoryProtocol: Sendable {

    /// Fetches and returns a list of recipes.
    func fetchRecipes() async throws -> [Recipe]
}
