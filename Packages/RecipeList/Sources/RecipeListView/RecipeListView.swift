//
//  RecipeListView.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

public import SwiftUI
import RecipeListCore

/// The main list view displaying a list of recipes.
public struct RecipeListView: View {

    // MARK: Properties

    /// A view model that manages the state and logic of the view.
    @State private var viewModel: ViewModel

    // MARK: Initializer

    public init() {
        self.viewModel = ViewModel()
    }

    // MARK: Body

    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    switch viewModel.loadState {
                    case .loading:
                        ProgressView()
                    case .reloading,
                         .success:
                        listView
                    case .failure:
                        Text("Recipes couldn't load. Please try again.")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .refreshable {
                await viewModel.loadRecipes()
            }
            .navigationTitle("Recipes")
        }
        .task {
            await viewModel.loadRecipes()
        }
    }

    // MARK: Subviews

    /// The list view of fetched recipes.
    private var listView: some View {
        LazyVStack {
            SortRecipesButtons(recipes: $viewModel.recipes)
                .padding(.leading)

            RecipeList(recipes: viewModel.recipes)
        }
    }
}
