//
//  RecipeListView+ViewModel.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

import AppFoundation
import Foundation
import RecipeListCore
import RecipeListData

extension RecipeListView {

    /// A view model that manages the state and logic of the view.
    @MainActor @Observable
    final class ViewModel {

        // MARK: Properties

        /// A use case responsible for fetching recipes.
        private let fetchRecipes: any FetchRecipesUseCaseProtocol

        /// The load state of the view
        var loadState: LoadState

        /// The list of recipes.
        var recipes: [Recipe]

        // MARK: Initializer

        init(fetchRecipesUseCase: any FetchRecipesUseCaseProtocol = FetchRecipesUseCase()) {
            self.fetchRecipes = fetchRecipesUseCase
            self.loadState = .loading
            self.recipes = []
        }

        // MARK: Functions

        /// Fetches and loads the list of recipes into `recipes`.
        func loadRecipes() async {
            if loadState == .success {
                loadState = .reloading
            } else {
                loadState = .loading
            }

            do {
                let fetchedRecipes = try await fetchRecipes()
                
                var recipesToKeep = recipes.filter { fetchedRecipes.contains($0) }
                recipesToKeep += fetchedRecipes.filter { !recipes.contains($0) }
                
                recipes = recipesToKeep
                loadState = .success
            } catch {
                loadState = .failure
            }
        }
    }
}
