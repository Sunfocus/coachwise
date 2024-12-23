//
//  SecureTextField.swift
//  Coachify
//
//  Created by ios on 13/12/24.
//
import SwiftUI

struct SecureTextField: View {
    
    @Binding var field: Field
    var isSecureText: Bool = false
    var isEditable: Bool = true // Property to control editability
    var buttonType: SubmitLabel = .done
    var keyboardType: UIKeyboardType = .default // Set keyboard type
    var autocapitalization: TextInputAutocapitalization = .never
    var onSubmit: (() -> Void)?
    
    @State private var onTapShowPassword: Bool = false
    @FocusState private var isFocused: Bool // Private Focus State

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // MARK: - Title Text
            Text(field.title)
                .customFont(.regular, 16)
            
            // MARK: - Input TextField
            HStack {
                if isSecureText && !onTapShowPassword {
                    // SecureField to obscure the text
                    SecureField(field.placeholder, text: $field.value)
                        .customFont(.regular, 14)
                        .keyboardType(keyboardType)
                        .tint(.cursorTint)
                        .focused($isFocused)
                        .disabled(!isEditable)
                        .submitLabel(buttonType)
                        .textContentType(.password)
                        .onSubmit { if isEditable { onSubmit?() } }
                    
                    
                    
                    
                } else {
                    // TextField to show the text
                    TextField(field.title, text: $field.value)
                        .customFont(.regular, 14)
                        .keyboardType(keyboardType)
                        .tint(.cursorTint)
                        .focused($isFocused)
                        .disabled(!isEditable)
                        .submitLabel(buttonType)
                        .onSubmit { if isEditable { onSubmit?() } }
                }

                // Eye Icon
                if isSecureText {
                    Button(action: {
                        onTapShowPassword.toggle()
                    }) {
                        Image(onTapShowPassword ? "eye" : "eyeClose")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.trailing, 10)
                }
            }
            .frame(height: 27)
            .padding(10)
            .padding(.horizontal, 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? .pink.opacity(0.5) : Color.gray, lineWidth: 1)
            )
            
            // Error Message
            if let error = field.error {
                Text(error.rawValue)
                    .customFont(.regular, 10)
                    .foregroundColor(.red)
            }
        }
    }
}


struct SecureTextField_Previews: PreviewProvider {
    @State static var field = Field(title: "Name", placeholder: "Enter your name") // Create a @State
    static var previews: some View {
        Group {
            // Editable text field with default settings
            SecureTextField(
                field: $field
            )
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}

