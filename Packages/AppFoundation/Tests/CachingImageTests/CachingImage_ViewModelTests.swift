//
//  CachingImage_ViewModelTests.swift
//  AppFoundation
//
//  Created by Jeffrey Li on 12/5/24.
//

import Foundation
import SwiftData
import SwiftUI
import Testing
@testable import CachingImage

@MainActor
struct CachingImage_ViewModelTests {

    @Test
    func lookForCachedImage() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CachedImage.self, configurations: config)

        let url = try #require(URL(string: "test"))
        let uiImage = try #require(ImageRenderer(content: Image(systemName: "person")).uiImage)
        let imageData = try #require(uiImage.pngData())
        
        let cachedImage = CachedImage(url: url.absoluteString, image: imageData)
        container.mainContext.insert(cachedImage)

        let sut = CachingImage.ViewModel(url: url)
        #expect(sut.url == url)
        #expect(!sut.hasLookedInCache)
        #expect(sut.cachedUIImage == nil)
        
        sut.lookForCachedImage(in: container.mainContext)
        #expect(sut.hasLookedInCache)
        let cachedUIImage = try #require(sut.cachedUIImage)
        #expect(cachedUIImage.pngData() == imageData)
    }

    @Test
    func cacheImage() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CachedImage.self, configurations: config)
        
        let url = try #require(URL(string: "test"))
        let image = Image(systemName: "person")

        var fetchDescriptor = FetchDescriptor<CachedImage>()
        fetchDescriptor.predicate = #Predicate { $0.url == url.absoluteString }

        let sut = CachingImage.ViewModel(url: url)
        sut.cacheImage(image, in: container.mainContext)

        let cachedResults = try container.mainContext.fetch(fetchDescriptor)
        #expect(cachedResults.count == 1)

        let cachedImage = try #require(cachedResults.first)
        let expectedImageData = ImageRenderer(content: image).uiImage?.pngData()
        #expect(cachedImage.url == url.absoluteString)
        #expect(cachedImage.image == expectedImageData)
    }
}
