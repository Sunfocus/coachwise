//
//  ScheduleButton.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 24/12/24.
//

import SwiftUI

struct ScheduleButton: View {
    let title: String
    let imageName: String?
    let fontSize: CGFloat
    let strokeBorderColor: Color
    let textColor: Color
    let action: () -> Void // Closure for the button action

    init(
        title: String,
        imageName: String? = nil,
        fontSize: CGFloat = 16,
        strokeBorderColor: Color = .primaryTheme,
        textColor: Color = .primaryTheme,
        action: @escaping () -> Void = {} // Default action does nothing
    ) {
        self.title = title
        self.imageName = imageName
        self.fontSize = fontSize
        self.strokeBorderColor = strokeBorderColor
        self.textColor = textColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack(alignment: .center) {
                if let imageName = imageName {
                    Image(imageName)
                }
                Text(title)
                    .customFont(.medium, fontSize)
                    .foregroundStyle(textColor)
            }
            .frame(maxWidth: .infinity)
        })
        .padding(.horizontal, 20)
        .frame(height: 48)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.primaryTheme, lineWidth: 1)
        }
    }
}

#Preview {
    ScheduleButton(title: "Add Schedule", imageName: "addSchedule")
}
