//
//  SecureTextField.swift
//  Coachify
//
//  Created by ios on 13/12/24.
//
import SwiftUI

struct SecureTextField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
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
            Text(title)
                .customFont(.regular, 16)
            
            // MARK: - Input TextField
            HStack {
                if isSecureText && !onTapShowPassword {
                    // SecureField to obscure the text
                    SecureField(placeholder, text: $text)
                        .customFont(.regular, 14)
                        .focused($isFocused)
                        .disabled(!isEditable)
                        .submitLabel(buttonType)
                        .textContentType(.password)
                        .keyboardType(keyboardType)
                        .onSubmit { if isEditable { onSubmit?() } }
                } else {
                    // TextField to show the text
                    TextField(placeholder, text: $text)
                        .customFont(.regular, 14)
                        .focused($isFocused)
                        .disabled(!isEditable)
                        .submitLabel(buttonType)
                        .keyboardType(keyboardType)
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
                    .stroke(isFocused ? .pink.opacity(0.2) : Color.gray, lineWidth: isFocused ? 3 : 1)
            )
        }
    }
}


struct SecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Editable text field with default settings
            SecureTextField(
                title: "Username",
                placeholder: "Enter your username",
                text: .constant(""),
                isSecureText: true
            )
            .previewLayout(.sizeThatFits)
            .padding()

          
        }
    }
}

