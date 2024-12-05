//
//  RecipeList+ListElementLabel.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/4/24.
//

import CachingImage
import RecipeListCore
import SwiftUI

extension RecipeList {
    /// A list label for a given recipe.
    struct ListElementLabel: View {
        // MARK: Properties

        /// The recipe for the label.
        let recipe: Recipe

        // MARK: Body

        var body: some View {
            HStack(spacing: 12) {
                recipeImage

                recipeLabelText

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }

        // MARK: Subviews

        /// The image of the recipe.
        private var recipeImage: some View {
            Group {
                if let stringURL = recipe.photoUrlSmall, let url = URL(string: stringURL) {
                    CachingImage(url: url)
                } else {
                    Color.gray
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: 64, height: 64)
        }

        /// The text label of the recipe.
        private var recipeLabelText: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.leading)

                Text(recipe.cuisine)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
