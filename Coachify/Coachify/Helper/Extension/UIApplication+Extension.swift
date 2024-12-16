//
//  UIApplication+Extension.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 13/12/24.
//

import UIKit

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
