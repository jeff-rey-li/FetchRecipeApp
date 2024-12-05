//
//  SortRecipesButtons.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/4/24.
//

import RecipeListCore
import SwiftUI

/// A set of buttons to sort recipes.
struct SortRecipesButtons: View {
    // MARK: Properties

    /// The list of recipes.
    @Binding var recipes: [Recipe]

    /// A view model that manages the logic of the view.
    var viewModel = ViewModel()

    // MARK: Body

    var body: some View {
        HStack {
            Text("Sort by:")
                .font(.system(size: 20, weight: .semibold, design: .rounded))

            sortByNameButton

            sortByCuisineButton

            Spacer()
        }
    }

    // MARK: Subviews

    /// The button to sort recipes by name.
    private var sortByNameButton: some View {
        Button {
            recipes = viewModel.sortRecipesByName(recipes: recipes)
        } label: {
            Text("Name")
        }
        .buttonStyle(.capsuleButtonStyle)
    }

    /// The button to sort recipes by cuisine.
    private var sortByCuisineButton: some View {
        Button {
            recipes = viewModel.sortRecipesByCuisine(recipes: recipes)
        } label: {
            Text("Cuisine")
        }
        .buttonStyle(.capsuleButtonStyle)
    }
}
