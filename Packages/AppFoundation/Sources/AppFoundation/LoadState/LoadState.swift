//
//  LoadState.swift
//  FetchRecipeApp
//
//  Created by Jeffrey Li on 12/3/24.
//

/// An enumeration representing the loading states of a view.
public enum LoadState: Equatable {

    case loading
    case reloading
    case success
    case failure
}
