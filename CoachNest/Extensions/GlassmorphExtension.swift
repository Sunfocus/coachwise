//
//  GlassmorphExtension.swift
//  CoachNest
//
//  Created by Rahul Pathania on 07/02/25.
//

import SwiftUI

extension View {
    func glassmorphicStyle(cornerRadius: CGFloat = 16) -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial) // Apple's built-in frosted glass effect
                    .blur(radius: 2) // Enhances the blur effect
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.2)) // Subtle white stroke for depth
            )
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5) // Soft shadow for depth
    }
}
