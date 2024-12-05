//
//  RecipeListRepository.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

package import RecipeListCore

/// A repository that manages fetching recipes.
package struct RecipeListRepository: RecipeListRepositoryProtocol {
    
    // MARK: Properties

    /// The service to use for fetching.
    let recipeListService: any RecipeListServiceProtocol
    
    // MARK: Initializer

    package init(recipeListService: any RecipeListServiceProtocol = RecipeListService()) {
        self.recipeListService = recipeListService
    }
    
    // MARK: Functions

    /// Fetches and returns a list of recipes.
    package func fetchRecipes() async throws -> [Recipe] {
        try await recipeListService.fetchRecipes()
    }
}
