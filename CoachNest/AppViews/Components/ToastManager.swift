//
//  ToastManager.swift
//  CoachNest
//
//  Created by Rahul Pathania on 06/02/25.
//

import SwiftUI

class ToastManager: ObservableObject {
    @Published var isShowing = false
    @Published var message = ""
    @Published var imageName = "exclamationmark.triangle.fill" // Default error icon
    
    func showToast(message: String, imageName: String = "exclamationmark.triangle.fill", duration: Double = 1.5) {
        self.message = message
        self.imageName = imageName
        withAnimation {
            isShowing = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                self.isShowing = false
            }
        }
    }
}
