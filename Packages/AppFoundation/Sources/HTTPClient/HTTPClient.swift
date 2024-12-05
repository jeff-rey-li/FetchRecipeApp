//
//  HTTPClient.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

public import Foundation

/// An HTTP client from which to make requests from.
public struct HTTPClient: HTTPClientProtocol {

    // MARK: Properties

    /// The URLSession to fetch the request with.
    private var urlSession: any URLSessionProtocol

    // MARK: Initializer

    public init(urlSession: any URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: Functions

    public func get<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw HTTPClientError.invalidURL
        }

        let (data, _) = try await urlSession.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

/// The errors that the ``HTTPClient`` can throw.
public enum HTTPClientError: Error {

    case invalidURL
}
