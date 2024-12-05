//
//  CachingImage.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

import SwiftData
public import SwiftUI

/// A view that loads an image at the specified `url` caches the image to disk.
public struct CachingImage: View {

    // MARK: Properties

    /// The SwiftData model context used for queries and other model operations.
    @Environment(\.modelContext) var modelContext

    /// A view model that manages the state and logic of the view.
    @State private var viewModel: ViewModel

    /// The URL to fetch the image at.
    private let url: URL

    // MARK: Initializer

    public init(url: URL) {
        self.url = url
        self.viewModel = ViewModel(url: url)
    }

    // MARK: Body

    public var body: some View {
        Group {
            if let cachedUIImage = viewModel.cachedUIImage {
                Image(uiImage: cachedUIImage)
                    .resizable()
            } else if viewModel.hasLookedInCache {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case let .success(image):
                        renderImageAndCache(image: image)
                    default:
                        Color.gray
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.lookForCachedImage(in: modelContext)
        }
        .onChange(of: url, updateUrlAndRefresh)
    }

    // MARK: Functions

    /// Renders the given image and caches it to disk.
    private func renderImageAndCache(image: Image) -> some View {
        viewModel.cacheImage(image, in: modelContext)

        return image.resizable()
    }

    /// Updates the view model's properties and refetches the image.
    private func updateUrlAndRefresh() {
        viewModel.url = url
        viewModel.hasLookedInCache = false
        viewModel.cachedUIImage = nil
        viewModel.lookForCachedImage(in: modelContext)
    }
}
