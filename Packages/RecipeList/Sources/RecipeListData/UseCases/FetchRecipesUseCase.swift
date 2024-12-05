//
//  FetchRecipesUseCase.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

package import RecipeListCore

/// A use case responsible for fetching the list of recipes.
package struct FetchRecipesUseCase: FetchRecipesUseCaseProtocol {

    // MARK: Properties

    /// The repository to fetch with.
    let recipeListRepository: any RecipeListRepositoryProtocol

    // MARK: Initializer

    package init(recipeListRepository: any RecipeListRepositoryProtocol = RecipeListRepository()) {
        self.recipeListRepository = recipeListRepository
    }

    // MARK: CallAsFunction

    public func callAsFunction() async throws -> [Recipe] {
        try await recipeListRepository.fetchRecipes()
    }
}
