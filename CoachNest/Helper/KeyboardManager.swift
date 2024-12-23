//
//  KeyboardManager.swift
//  CoachNest
//
//  Created by ios on 20/12/24.
//

import SwiftUI

final class KeyboardManager: ObservableObject {
    static let shared = KeyboardManager()

    @Published var keyboardHeight: CGFloat = 0

    private init() {
        setupKeyboardObservers()
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.keyboardHeight = keyboardFrame.height
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.keyboardHeight = 0
        }
    }
}

