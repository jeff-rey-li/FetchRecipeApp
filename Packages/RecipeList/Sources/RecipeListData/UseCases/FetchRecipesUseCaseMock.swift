//
//  FetchRecipesUseCaseMock.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

import os
package import RecipeListCore

#if DEBUG

/// A mock of the ``FetchRecipesUseCaseProtocol``.
package final class FetchRecipesUseCaseMock: FetchRecipesUseCaseProtocol {

    package init() {
        self._error = OSAllocatedUnfairLock(initialState: nil)
        self._run = OSAllocatedUnfairLock(initialState: nil)
        self._returnValue = OSAllocatedUnfairLock(initialState: [])
    }

    private let _error: OSAllocatedUnfairLock<(any Error)?>

    /// The error to throw for the `callAsFunction` function.
    package var error: (any Error)? {
        get {
            _error.withLock { $0 }
        }
        set {
            _error.withLock { $0 = newValue }
        }
    }

    private let _run: OSAllocatedUnfairLock<(@Sendable () -> Void)?>

    /// A block of code to run during the `callAsFunction` function.
    package var run: (@Sendable () -> Void)? {
        get {
            _run.withLock { $0 }
        }
        set {
            _run.withLock { $0 = newValue }
        }
    }

    private let _returnValue: OSAllocatedUnfairLock<[Recipe]>

    /// The return value for the `callAsFunction` function.
    package var returnValue: [Recipe] {
        get {
            _returnValue.withLock { $0 }
        }
        set {
            _returnValue.withLock { $0 = newValue }
        }
    }

    package func callAsFunction() async throws -> [Recipe] {
        if let error {
            throw error
        }

        run?()

        return returnValue
    }

    package enum MockError: Error {
        case invalidReturnValue
    }
}

#endif
