//
//  RecipeListServiceTests.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

import HTTPClient
import RecipeListCore
import Testing
@testable import RecipeListData

struct RecipeListServiceTests {

    @Test(
        arguments: [
            [],
            [
                Recipe(cuisine: "Italian", name: "Pizza"),
                Recipe(cuisine: "American", name: "Burger"),
                Recipe(cuisine: "Japanese", name: "Sushi")
            ]
        ]
    )
    func fetchRecipes(recipes: [Recipe]) async throws {
        let httpClient = HTTPClientMock()
        httpClient.getReturnValue = RecipesDTO(recipes: recipes)
        let sut = RecipeListService(httpClient: httpClient)
        
        let result = try await sut.fetchRecipes()
        
        #expect(result == recipes)
    }
    
    @Test
    func fetchRecipesFailure() async throws {
        let httpClient = HTTPClientMock()
        httpClient.getError = HTTPClientError.invalidURL
        let sut = RecipeListService(httpClient: httpClient)
                
        await #expect(throws: HTTPClientError.invalidURL) {
            try await sut.fetchRecipes()
        }
    }
}
