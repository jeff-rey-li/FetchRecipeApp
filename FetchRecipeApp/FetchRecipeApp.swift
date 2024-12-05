//
//  FetchRecipeAppApp.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

import SwiftUI
import CachingImage

@main
struct FetchRecipeApp: App {
    var body: some Scene {
        WindowGroup {
            Root()
        }
        .modelContainer(for: CachedImage.self)
    }
}
