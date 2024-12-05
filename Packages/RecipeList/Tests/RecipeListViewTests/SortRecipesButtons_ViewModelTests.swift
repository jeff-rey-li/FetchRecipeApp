//
//  SortRecipesButtons_ViewModelTests.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

import RecipeListCore
import Testing
@testable import RecipeListView

struct SortRecipesButtons_ViewModelTests {

    @Test(
        arguments: [
            (
                recipes: [Recipe](),
                expected: [Recipe]()
            ),
            (
                recipes: [
                    Recipe(cuisine: "Italian", name: "Pizza"),
                    Recipe(cuisine: "American", name: "Burger"),
                    Recipe(cuisine: "Japanese", name: "Sushi"),
                    Recipe(cuisine: "German", name: "Bratwurst")
                ],
                expected: [
                    Recipe(cuisine: "German", name: "Bratwurst"),
                    Recipe(cuisine: "American", name: "Burger"),
                    Recipe(cuisine: "Italian", name: "Pizza"),
                    Recipe(cuisine: "Japanese", name: "Sushi")
                ]
            )
        ]
    )
    func sortByName(recipes: [Recipe], expected: [Recipe]) throws {
        let sut = SortRecipesButtons.ViewModel()
        let output = sut.sortRecipesByName(recipes: recipes)

        #expect(output.map(\.name) == expected.map(\.name))
    }

    @Test(
        arguments: [
            (
                recipes: [Recipe](),
                expected: [Recipe]()
            ),
            (
                recipes: [
                    Recipe(cuisine: "Italian", name: "Pizza"),
                    Recipe(cuisine: "American", name: "Burger"),
                    Recipe(cuisine: "Japanese", name: "Sushi"),
                    Recipe(cuisine: "German", name: "Bratwurst")
                ],
                expected: [
                    Recipe(cuisine: "American", name: "Burger"),
                    Recipe(cuisine: "German", name: "Bratwurst"),
                    Recipe(cuisine: "Italian", name: "Pizza"),
                    Recipe(cuisine: "Japanese", name: "Sushi")
                ]
            )
        ]
    )
    func sortByCuisine(recipes: [Recipe], expected: [Recipe]) throws {
        let sut = SortRecipesButtons.ViewModel()
        let output = sut.sortRecipesByCuisine(recipes: recipes)

        #expect(output.map(\.cuisine) == expected.map(\.cuisine))
    }
}
