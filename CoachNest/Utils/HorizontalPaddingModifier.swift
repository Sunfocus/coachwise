//
//  HorizontalPaddingModifier.swift
//  Spending
//
//  Created by sunfocus solution on 22/11/24.
//

import SwiftUI

struct HorizontalPaddingModifier: ViewModifier {
    var paddingValue: CGFloat

    func body(content: Content) -> some View {
        content
            .padding([.leading, .trailing], paddingValue)
    }
}

extension View {
    func horizontalPadding(_ value: CGFloat) -> some View {
        self.modifier(HorizontalPaddingModifier(paddingValue: value))
    }
}

struct VerticalPaddingModifier: ViewModifier {
    var paddingValue: CGFloat

    func body(content: Content) -> some View {
        content
            .padding([.top, .bottom], paddingValue)
    }
}

extension View {
    func verticalPadding(_ value: CGFloat) -> some View {
        self.modifier(VerticalPaddingModifier(paddingValue: value))
    }
}

struct EdgePaddingModifier: ViewModifier {
    var horizontal: CGFloat
    var vertical: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
    }
}

extension View {
    func edgePadding(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> some View {
        self.modifier(EdgePaddingModifier(horizontal: horizontal, vertical: vertical))
    }
}
