//
//  AppearanceManager.swift
//  Spending
//
//  Created by sunfocus solution on 20/11/24.
//

import SwiftUI

class AppearanceManager: ObservableObject {
    enum AppearanceMode: String {
        case light
        case dark
        case system
    }
    
    @Published var currentMode: AppearanceMode {
        didSet {
            saveAppearanceMode(currentMode)
            applyAppearanceMode(currentMode)
        }
    }
    
    private let appearanceKey = "userAppearancePreference"
    
    init() {
        // Retrieve saved appearance mode from UserDefaults, default to 'system' if not found
        let savedMode = UserDefaults.standard.string(forKey: appearanceKey)
        
        // If the saved mode exists, initialize 'currentMode' with it, otherwise determine it based on system appearance
        if let savedMode = savedMode,
           let mode = AppearanceMode(rawValue: savedMode) {
            currentMode = mode
        } else {
            // Fallback to system appearance if no saved mode exists
            currentMode = UIScreen.main.traitCollection.userInterfaceStyle == .dark ? .dark : .light
        }
        // Apply the appearance mode (light, dark, or system) to the app
        applyAppearanceMode(currentMode)
    }

    
    private func saveAppearanceMode(_ mode: AppearanceMode) {
        UserDefaults.standard.setValue(mode.rawValue, forKey: appearanceKey)
    }
    
    func applyAppearanceMode(_ mode: AppearanceMode) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        let style: UIUserInterfaceStyle
        switch mode {
        case .light:
            style = .light
        case .dark:
            style = .dark
        case .system:
            style = UIScreen.main.traitCollection.userInterfaceStyle == .dark ? .dark : .light
        }
        
        // Apply the style to all windows in the scene
        for window in windowScene.windows {
            window.overrideUserInterfaceStyle = style
        }
    }
}
