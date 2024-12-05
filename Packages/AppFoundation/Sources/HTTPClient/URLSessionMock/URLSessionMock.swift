//
//  URLSessionMock.swift
//  AppFoundation
//
//  Created by Jeffrey Li on 12/5/24.
//

import Foundation
import os

#if DEBUG

/// A mock for ``URLSessionProtocol``.
final class URLSessionMock: URLSessionProtocol {

    init() {
        self._error = OSAllocatedUnfairLock(initialState: nil)
        self._run = OSAllocatedUnfairLock(initialState: nil)
        self._returnValue = OSAllocatedUnfairLock(initialState: nil)
    }

    private let _error: OSAllocatedUnfairLock<(any Error)?>

    /// The error to throw for the `data` function.
    package var error: (any Error)? {
        get {
            _error.withLock { $0 }
        }
        set {
            _error.withLock { $0 = newValue }
        }
    }

    private let _run: OSAllocatedUnfairLock<(@Sendable (URL) -> Void)?>

    /// A block of code to run during the `data` function.
    package var run: (@Sendable (URL) -> Void)? {
        get {
            _run.withLock { $0 }
        }
        set {
            _run.withLock { $0 = newValue }
        }
    }

    private let _returnValue: OSAllocatedUnfairLock<(Data, URLResponse)?>

    /// The return value for the `data` function.
    package var returnValue: (Data, URLResponse)? {
        get {
            _returnValue.withLock { $0 }
        }
        set {
            _returnValue.withLock { $0 = newValue }
        }
    }

    func data(
        from url: URL,
        delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }

        run?(url)

        return returnValue ?? (Data(), URLResponse())
    }
}

#endif
