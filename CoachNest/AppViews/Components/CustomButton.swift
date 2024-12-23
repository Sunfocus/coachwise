//
//  LoginButtonView.swift
//  BeYou
//
//  Created by Sunfocus Solutions on 11/11/24.
//

import SwiftUI


enum ButtonStyle {
    case capsule
    case rectangle
}

struct CustomButton: View {
    let title: String
    let imageName: String?
    let fontSize: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void // Closure for the button action
    let buttonType: ButtonStyle

    init(
        title: String,
        imageName: String? = nil,
        fontSize: CGFloat = 16,
        backgroundColor: Color = .primaryTheme,
        textColor: Color = .white,
        buttonType: ButtonStyle = .rectangle, // Default to rectangle
        action: @escaping () -> Void = {} // Default action does nothing
    ) {
        self.title = title
        self.imageName = imageName
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.buttonType = buttonType
        self.action = action
    }
    
    var body: some View {
        Button(action: action) { // Use Button to handle the tap action
            HStack {
                Text(title)
                    .foregroundColor(textColor)
                    .customFont(.medium, fontSize)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                
                if let imageName = imageName {
                    Image(imageName)
                        .foregroundColor(textColor)
                }
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(
                buttonType == .capsule ? RoundedRectangle(cornerRadius: 30) : RoundedRectangle(cornerRadius: 10)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
