//
//  RecipeListView_ViewModelTests.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/4/24.
//

import AppFoundation
import RecipeListCore

// import HTTPClient
import RecipeListData
import Testing
@testable import RecipeListView

@MainActor
struct RecipeListiew_ViewModelTests {

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
    func successfulLoadRecipes(recipes: [Recipe]) async {
        let fetchRecipesUseCaseMock = FetchRecipesUseCaseMock()
        fetchRecipesUseCaseMock.returnValue = recipes

        let sut = RecipeListView.ViewModel(fetchRecipesUseCase: fetchRecipesUseCaseMock)

        #expect(sut.loadState == .loading)
        #expect(sut.recipes == [])

        await confirmation { confirmation in
            fetchRecipesUseCaseMock.run = { confirmation() }

            await sut.loadRecipes()
        }

        #expect(sut.loadState == .success)
        #expect(sut.recipes == recipes)
    }

    @Test
    func reloadRecipesWithNewRecipes() async {
        let initialRecipes = [
            Recipe(cuisine: "Italian", name: "Pizza"),
            Recipe(cuisine: "American", name: "Burger")
        ]
        let fetchRecipesUseCaseMock = FetchRecipesUseCaseMock()
        fetchRecipesUseCaseMock.returnValue = initialRecipes

        let sut = RecipeListView.ViewModel(fetchRecipesUseCase: fetchRecipesUseCaseMock)
        await sut.loadRecipes()

        #expect(sut.recipes == initialRecipes)
        
        let newRecipes = [
            Recipe(cuisine: "Italian", name: "Pizza"),
            Recipe(cuisine: "Sushi", name: "Japanese")
        ]
        
        fetchRecipesUseCaseMock.returnValue = newRecipes
        await sut.loadRecipes()

        #expect(sut.recipes == newRecipes)
    }

    @Test
    func failureLoadRecipes() async {
        enum TestError: Error {
            case test
        }

        let fetchRecipesUseCaseMock = FetchRecipesUseCaseMock()
        fetchRecipesUseCaseMock.error = TestError.test

        let sut = RecipeListView.ViewModel(fetchRecipesUseCase: fetchRecipesUseCaseMock)

        #expect(sut.loadState == .loading)
        #expect(sut.recipes == [])

        await sut.loadRecipes()

        #expect(sut.loadState == .failure)
        #expect(sut.recipes == [])
    }
}
