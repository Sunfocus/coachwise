//
//  CustomTextField.swift
//  Coachify
//
//  Created by ios on 13/12/24.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var isEditable: Bool = true
    var buttonType: SubmitLabel = .done
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .never
    var onSubmit: (() -> Void)?
    
    
    @FocusState private var isFocused: Bool // Private Focus State

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // MARK: - Title Text
            Text(title)
                .customFont(.regular, 16)
            
            // MARK: - Input TextField
            TextField(placeholder, text: $text)
                .customFont(.regular, 14)
                .keyboardType(keyboardType) // Set keyboard type
                .disabled(!isEditable) // Disable editing when isEditable is false
                .frame(height: 27)
                .tint(.cursorTint)
                .padding(10)
                .padding(.horizontal, 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isFocused ? .pink.opacity(0.5) : Color.gray, lineWidth: 1)
                )
                .focused($isFocused) // Attach focus state
                .submitLabel(buttonType)
                .onSubmit { if isEditable { onSubmit?() } }
        }
    }
}


struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Editable text field with default settings
            CustomTextField(
                title: "Username",
                placeholder: "Enter your username",
                text: .constant("")
            )
            .previewLayout(.sizeThatFits)
            .padding()

          
        }
    }
}


