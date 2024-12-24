//
//  TextEditorWithPlaceholder.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 18/11/24.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    var placeholder: String = "Write something..."
    var font: Font = .customFont(.regular, 14)
    var cursorColor: Color = .cursorTint
    var placeholderColor: Color = .gray
    var backgroundColor: Color = .white
    var cornerRadius: CGFloat = 15
    var frameHeight: CGFloat = 150
    var maxCharacters: Int = 500

    var body: some View {
        ZStack {
            // Placeholder
            HStack(alignment: .top){
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(placeholderColor) // Placeholder color is set to gray
                        .font(font)
                        .padding(.horizontal, 12)
                       .padding(.top, 15)
                }
                
                // TextEditor
                TextEditor(text: $text)
                    .font(font)
                    .foregroundColor(.black)
                    .frame(height: frameHeight)
                    .padding(8)
                    .tint(cursorColor)
                    .scrollContentBackground(.hidden)
                    .background(backgroundColor) // Frame color is white
                    .cornerRadius(cornerRadius)
                    .onChange(of: text, { oldValue, newValue in
                        if newValue.count > maxCharacters {
                            text = String(newValue.prefix(maxCharacters))
                        }
                    })
                Spacer()
            }
            
        }
        .background(backgroundColor) // Frame color is white
        .cornerRadius(cornerRadius)
    }
}

struct TextEditorWithPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        // A state variable to test the TextEditor in the preview
        @State var text = ""

        return TextEditorWithPlaceholder(
            text: $text,
            placeholder: "Write your message here...",
            font: .customFont(.regular, 14),
            cursorColor: .blue,
            placeholderColor: .gray, // Placeholder color explicitly set to gray
            backgroundColor: Color.white, // Frame color explicitly set to white
            cornerRadius: 15,
            frameHeight: 150,
            maxCharacters: 200
        )
        .padding()
        .previewLayout(.sizeThatFits) // Ensures proper preview layout
    }
}
