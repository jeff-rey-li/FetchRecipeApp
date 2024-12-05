//
//  RecipeView.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/4/24.
//

import CachingImage
import RecipeListCore
import SwiftUI

/// A detail view for a recipe.
struct RecipeView: View {
    
    // MARK: Properties

    /// The recipe to show details for.
    let recipe: Recipe
    
    // MARK: Body

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                recipeImage

                recipeLabel
            }

            recipeLinks
        }
        .padding(.horizontal)
    }
    
    // MARK: Subviews

    /// The image of the recipe.
    private var recipeImage: some View {
        Group {
            if let stringURL = recipe.photoUrlLarge, let url = URL(string: stringURL) {
                CachingImage(url: url)
            } else {
                Color.gray
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(width: 312, height: 312)
    }

    /// The text label for the recipe.
    private var recipeLabel: some View {
        VStack(spacing: 4) {
            Text(recipe.name)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)

            Text(recipe.cuisine)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
        }
    }

    /// The links associated with the recipe.
    private var recipeLinks: some View {
        HStack {
            Spacer()
            sourceLink
            Spacer()
            youtubeLink
            Spacer()
        }
        .font(.system(size: 20, weight: .bold, design: .rounded))
    }

    /// The source link associated with the recipe.
    @ViewBuilder
    private var sourceLink: some View {
        if let sourceUrl = recipe.sourceUrl, let url = URL(string: sourceUrl) {
            Link("Source", destination: url)
        } else {
            Text("Source")
                .foregroundStyle(.black.opacity(0.1))
        }
    }

    /// The youtube link associated with the recipe.
    @ViewBuilder
    private var youtubeLink: some View {
        if let youtubeUrl = recipe.youtubeUrl, let url = URL(string: youtubeUrl) {
            Link("YouTube", destination: url)
        } else {
            Text("YouTube")
                .foregroundStyle(.black.opacity(0.1))
        }
    }
}
