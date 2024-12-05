//
//  SortRecipesButtons+ViewModel.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

import RecipeListCore

extension SortRecipesButtons {

    /// A view model that manages the logic of the view.
    struct ViewModel {

        // MARK: Functions

        func sortRecipesByName(recipes: [Recipe]) -> [Recipe] {
            recipes.sorted {
                $0.name < $1.name
            }
        }

        func sortRecipesByCuisine(recipes: [Recipe]) -> [Recipe] {
            recipes.sorted {
                $0.cuisine < $1.cuisine
            }
        }
    }
}
