//
//  CapsuleButtonStyle.swift
//  RecipeList
//
//  Created by Jeffrey Li on 12/5/24.
//

import SwiftUI

/// A capsule style button style.
struct CapsuleButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .padding(8)
            .background(Color.gray.opacity(0.2))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.spring, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == CapsuleButtonStyle {

    /// A capsule style button style.
    static var capsuleButtonStyle: CapsuleButtonStyle { CapsuleButtonStyle() }
}
