//
//  RecipesDTO.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

/// A DTO for fetching recipes.
package struct RecipesDTO: Decodable {

    /// The list of recipes.
    package var recipes: [Recipe]

    package init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}
