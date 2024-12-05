//
//  RecipeList.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

import RecipeListCore
import SwiftUI

/// A view displaying a list of recipes.
struct RecipeList: View {
    // MARK: Properties

    /// The list of recipes.
    var recipes: [Recipe]

    // MARK: Initializer

    init(recipes: [Recipe]) {
        self.recipes = recipes
    }

    // MARK: Body

    var body: some View {
        if recipes.isEmpty {
            Text("No recipes")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .padding(32)
        } else {
            ForEach(recipes) { recipe in
                NavigationLink {
                    RecipeView(recipe: recipe)
                } label: {
                    ListElementLabel(recipe: recipe)
                        .padding(.horizontal)
                }
                .tint(.primary)

                Divider()
                    .padding(.horizontal)
            }
        }
    }
}
