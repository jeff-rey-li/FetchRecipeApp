//
//  HTTPClientProtocol.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/4/24.
//

/// A protocol indicating the possible request types for an HTTP client.
public protocol HTTPClientProtocol: Sendable {

    /// Sends an  GET request to the given `endpoint` and decodes the response to the specified type.
    func get<T: Decodable>(endpoint: String) async throws -> T
}
