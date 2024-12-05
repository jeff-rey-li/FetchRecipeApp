//
//  CachingImage+ViewModel.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

import SwiftData
import SwiftUI

extension CachingImage {

    /// A view model that manages the state and logic of the view.
    @MainActor @Observable
    final class ViewModel {

        // MARK: Properties

        /// The URL to fetch the image at.
        var url: URL

        /// A Boolean value indicating if the image was searched for in the cache.
        var hasLookedInCache: Bool

        /// The cached image as a ``UIImage``, if it exists.
        var cachedUIImage: UIImage?

        // MARK: Initializer

        init(url: URL) {
            self.url = url
            self.hasLookedInCache = false
            self.cachedUIImage = nil
        }

        // MARK: Functions

        /// Looks for an image at the `url` key in `modelContext` and updates `cachedUIImage` if an image exists.
        func lookForCachedImage(in modelContext: ModelContext) {
            var fetchDescriptor = FetchDescriptor<CachedImage>()
            fetchDescriptor.predicate = #Predicate { $0.url == url.absoluteString }
            fetchDescriptor.fetchLimit = 1
            do {
                if let cachedImage = try modelContext.fetch(fetchDescriptor).first {
                    cachedUIImage = UIImage(data: cachedImage.image)
                }
                
                hasLookedInCache = true
            } catch {}
        }

        /// Attempts to store the given `image` in `modelContext`.
        func cacheImage(_ image: Image, in modelContext: ModelContext) {
            let uiImage = ImageRenderer(content: image).uiImage
            guard let pngData = uiImage?.pngData() else {
                return
            }
            
            let cachedImage = CachedImage(url: url.absoluteString, image: pngData)
            modelContext.insert(cachedImage)
        }
    }
}
