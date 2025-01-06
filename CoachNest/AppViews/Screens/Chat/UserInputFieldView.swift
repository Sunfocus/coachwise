//
//  CommentTextView.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 09/12/24.
//

import SwiftUI

struct UserInputFieldView: View {
    @Binding var text: String
    let placeholder: String
    let actionButtonImage: Image
    let onSend: () -> Void
    
    var body: some View {
        HStack {
           
            HStack{
                TextField(placeholder, text: $text)
                    .customFont(.regular, 16)
                    .padding()
                    .foregroundStyle(.white)
                    
                
                if !text.isEmpty {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                        .padding()
                        .onTapGesture {
                            onSend()
                        }
                }
            }
            .background(Color.primaryTheme.opacity(0.4))
               .cornerRadius(20)
        }
        .padding()
    }
}

#Preview {
    StatefulPreviewWrapper("") { text in
        AnyView(
            UserInputFieldView(
                text: text,
                placeholder: "Write your message",
                actionButtonImage: Image(systemName: "paperplane.fill"),
                onSend: {
                    print("Message sent: \(text.wrappedValue)")
                    text.wrappedValue = "" // Clear the text
                }
            )
        )
    }
}

struct StatefulPreviewWrapper<Value>: View {
    @State private var value: Value
    let content: (Binding<Value>) -> AnyView

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> AnyView) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
