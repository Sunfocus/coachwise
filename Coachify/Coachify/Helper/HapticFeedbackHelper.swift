//
//  HapticFeedbackHelper.swift
//  InAppSubscriptionDemo
//
//  Created by Sunfocus Solutions on 21/05/24.
//

import Foundation
import UIKit

class HapticFeedbackHelper {
    
    static func generateImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    // Convenience methods for common feedback styles
    static func lightImpact() {
        generateImpactFeedback(style: .light)
    }
    
    static func mediumImpact() {
        generateImpactFeedback(style: .medium)
    }
    
    static func heavyImpact() {
        generateImpactFeedback(style: .heavy)
    }
    
    static func softImpact() {
        if #available(iOS 13.0, *) {
            generateImpactFeedback(style: .soft)
        }
    }
    
    static func rigidImpact() {
        if #available(iOS 13.0, *) {
            generateImpactFeedback(style: .rigid)
        }
    }
}

