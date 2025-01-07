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
    let onSend: () -> Void
    @State var isRecording: Bool = false
    
    var body: some View {
        
        VStack{
            Divider()
            HStack{
                Spacer()
                Button {
                    isRecording ? isRecording.toggle() : print("attach docs")
                } label: {
                    if isRecording{
                        Image(.deleteLines)
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundStyle(.primaryTheme)
                            .padding(9)
                            .background(.primaryTheme.opacity(0.2))
                            .clipShape(.rect(cornerRadius: 12.0))
                    }else{
                        Image(.attachmentPin)
                            .resizable()
                            .frame(width:  24, height:  24)
                    }
                }
                
                HStack{
                    if isRecording{
                        AudioWaveformView()  
                    }else{
                        TextField(placeholder, text: $text)
                            .customFont(.regular, 14)
                            .padding(10)
                        
                        if text.isEmpty {
                            Image(.files)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    onSend()
                                }
                                .padding(.trailing)
                        }
                    }
                    
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 5)
                
                
                if text.isEmpty && !isRecording{
                    Image(.camera)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            onSend()
                        }
                    
                    Image(.microphone)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            isRecording.toggle()
                        }
                }else{
                    Button {
                        onSend()
                        isRecording ? isRecording.toggle() : print("no record")
                        
                    } label: {
                        Image(.send)
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundStyle(.primaryTheme)
                            .padding(9)
                            .background(.primaryTheme.opacity(0.2))
                            .clipShape(.rect(cornerRadius: 12.0))
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    StatefulPreviewWrapper("") { text in
        AnyView(
            UserInputFieldView(
                text: text,
                placeholder: "Write your message",
                onSend: {
                    print("Message sent: \(text.wrappedValue)")
                    text.wrappedValue = ""
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
