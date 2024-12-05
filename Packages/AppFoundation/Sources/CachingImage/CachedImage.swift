//
//  CachedImage.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

import Foundation
public import SwiftData

/// An object representing a cached image on the disk.
@Model
public final class CachedImage {

    // MARK: Properties

    /// The URL string associated with the image.
    @Attribute(.unique) var url: String

    /// The PNG data of the image.
    @Attribute(.externalStorage) var image: Data

    // MARK: Initializer

    init(url: String, image: Data) {
        self.url = url
        self.image = image
    }
}
