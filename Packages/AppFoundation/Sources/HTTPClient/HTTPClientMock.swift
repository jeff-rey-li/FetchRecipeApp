//
//  HTTPClientMock.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/4/24.
//

import os

#if DEBUG

/// A mock of the ``HTTPClientProtocol``.
public final class HTTPClientMock: HTTPClientProtocol {

    public init() {
        self._getError = OSAllocatedUnfairLock(initialState: nil)
        self._getRun = OSAllocatedUnfairLock(initialState: nil)
        self._getReturnValue = OSAllocatedUnfairLock(initialState: nil)
    }

    private let _getError: OSAllocatedUnfairLock<(any Error)?>

    /// The error to throw for the `get` function.
    public var getError: (any Error)? {
        get {
            _getError.withLock { $0 }
        }
        set {
            _getError.withLock { $0 = newValue }
        }
    }

    private let _getRun: OSAllocatedUnfairLock<(@Sendable () -> Void)?>

    /// A block of code to run during the `get` function.
    public var getRun: (@Sendable () -> Void)? {
        get {
            _getRun.withLock { $0 }
        }
        set {
            _getRun.withLock { $0 = newValue }
        }
    }

    private let _getReturnValue: OSAllocatedUnfairLock<(any Sendable)?>

    /// The return value for the `get` function.
    public var getReturnValue: (any Sendable)? {
        get {
            _getReturnValue.withLock { $0 }
        }
        set {
            _getReturnValue.withLock { $0 = newValue }
        }
    }

    public func get<T: Decodable & Sendable>(endpoint: String) async throws -> T {
        if let getError {
            throw getError
        }

        getRun?()

        guard let returnValue = getReturnValue as? T else {
            throw MockError.invalidReturnValue
        }

        return returnValue
    }

    public enum MockError: Error {
        case invalidReturnValue
    }
}

#endif
