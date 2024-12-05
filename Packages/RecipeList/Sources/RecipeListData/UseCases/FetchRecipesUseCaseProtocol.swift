//
//  FetchRecipesUseCaseProtocol.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

package import RecipeListCore

/// A use case responsible for fetching the list of recipes.
package protocol FetchRecipesUseCaseProtocol: Sendable {

    func callAsFunction() async throws -> [Recipe]
}
