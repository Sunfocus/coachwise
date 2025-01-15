//
//  AddNoteFieldView.swift
//  CoachNest
//
//  Created by ios on 15/01/25.
//

import SwiftUI

struct AddNoteInputFieldView: View {
    @Binding var text: String
    @ObservedObject var viewModel: EventDetailViewModel
    let placeholder: String
    let userImage: UIImage
    let actionButtonImage: UIImage
    let onSend: () -> Void
    @FocusState private var isTextFieldFocused: Bool
        
        
    
    var body: some View {
        HStack {
            HStack{
                Image(uiImage: userImage)
                    .resizable()
                    .frame(width: 27, height: 27)
                    .clipShape(Circle())
                
                TextField(placeholder, text: $text)
                    .customFont(.regular, 15)
                    .padding(.vertical, 12)
                    .padding(.leading, 12)
                    .focused($isTextFieldFocused)
                    .onChange(of: isTextFieldFocused, { oldValue, newValue in
                        viewModel.isTextFieldFocused = newValue
                    })
                
                    Image(uiImage: actionButtonImage)
                        .resizable()
                        .frame(width: 27, height: 27)
                        .padding(.trailing, 5)
                        .onTapGesture {
                            onSend()
                        }
            }
        }
       
        .padding()
        .frame(height: 48)
        .background(.darkGreyBackground)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.primary, lineWidth: 0.6)
        }
        
    }
}

#Preview {
    StatefulPreviewWrapper("") { text in
        AnyView(
            AddNoteInputFieldView(
                text: text,
                viewModel: EventDetailViewModel(),
                placeholder: "Write a comment...",
                userImage: .sg1,
                actionButtonImage: .plane,
                onSend: {
                    print("Message sent: \(text.wrappedValue)")
                    text.wrappedValue = "" // Clear the text
                }
                
            )
        )
    }
}
