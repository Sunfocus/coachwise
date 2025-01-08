//
//  CommentTextView.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 09/12/24.
//

import SwiftUI
import PhotosUI

struct UserInputFieldView: View {
    @Binding var text: String
    @Binding var images: [UIImage]
    @Binding var photosPickerItems: [PhotosPickerItem]
    @State var isRecording: Bool = false
    @ObservedObject var audioRecorder: AudioRecorderHelper
    
    
    let placeholder: String
    let onSend: (MessageType) -> Void
    
    var body: some View {
        VStack{
            Divider()
            HStack{
                Spacer()
                Button {
                    isRecording ? isRecording.toggle() : print("attach docs pin23")
                } label: {
                    if isRecording{
                        Image(.deleteButtonLines)
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
                                    onSend(.document)
                                }
                                .padding(.trailing)
                        }
                    }
                    
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 5)
                
                
                if text.isEmpty && !isRecording{
                    
                    
                    PhotosPicker(
                        selection: $photosPickerItems,
                        maxSelectionCount: 5, // Max number of images to select
                        matching: .images // Only allow images
                    ) {
                        Image(.camera)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    Image(.microphone)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                           audioRecorder.startRecording()
                           isRecording.toggle()
                        }
                }else{
                    Button {
                        isRecording ? onSend(.audio) : onSend(.text)
                        isRecording ? audioRecorder.stopRecording() : print("no record")
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
        }.onChange(of: photosPickerItems) { _, _ in
            Task{
                for item in photosPickerItems{
                    if let data = try? await item.loadTransferable(type: Data.self){
                        if let image = UIImage(data: data){
                            images.append(image)
                        }
                    }
                }
                onSend(.image)
            }
        }
    }
}

#Preview {
    StatefulPreviewWrapper("") { text in
        AnyView(
            UserInputFieldView(
                text: text,
                images: .constant([UIImage()]),
                photosPickerItems: .constant([PhotosPickerItem(itemIdentifier: "")]),
                audioRecorder: AudioRecorderHelper(),
                placeholder: "Write your message",
                onSend: { _ in 
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
