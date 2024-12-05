//
//  URLSessionProtocol.swift
//  AppFoundation
//
//  Created by Jeffrey Li on 12/5/24.
//

public import Foundation

/// An object that coordinates a group of related, network data transfer tasks.
public protocol URLSessionProtocol: Sendable {

    /// Retrieves data from the given `url`.
    func data(
        from url: URL,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSessionProtocol {

    func data(
        from url: URL,
        delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        try await data(from: url, delegate: delegate)
    }
}

// MARK: - URLSession + URLSessionProtocol

extension URLSession: URLSessionProtocol {}
