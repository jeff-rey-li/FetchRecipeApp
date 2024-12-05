//
//  HTTPClientTests.swift
//  AppFoundation
//
//  Created by Jeffrey Li on 12/4/24.
//

import Foundation
import Testing
@testable import HTTPClient

struct HTTPClientTests {
    
    struct Test: Decodable {
        var test: String
    }

    @Test
    func get() async throws {
        let response =
            """
            {
              "test": "test"
            }
            """
            .data(using: .utf8) ?? Data()
        let endpoint = "endpoint"

        let urlSessionMock = URLSessionMock()
        urlSessionMock.run = { url in
            #expect(url.absoluteString == endpoint)
        }
        urlSessionMock.returnValue = (response, URLResponse())
        
        let sut = HTTPClient(urlSession: urlSessionMock)
        let result: Test = try await sut.get(endpoint: endpoint)
        
        #expect(result.test == "test")
    }
}
