//
//  KeyboardToolbar.swift
//  CoachNest
//
//  Created by Rahul Pathania on 03/02/25.
//


import SwiftUI

struct KeyboardToolbarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer() // Pushes the button to the right
                    Button(action: {
                        hideKeyboard()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
    }

    // Function to dismiss the keyboard
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func keyboardToolbar() -> some View {
        self.modifier(KeyboardToolbarModifier())
    }
}
