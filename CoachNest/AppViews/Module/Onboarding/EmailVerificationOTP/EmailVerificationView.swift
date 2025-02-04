//
//  EmailVerificationView.swift
//  Coachify
//
//  Created by ios on 13/12/24.
//

import SwiftUI

enum OTPField: Hashable {
    case pin1, pin2, pin3, pin4
}

struct EmailVerificationView: View {
    
    //MARK: - @State variables -
    @State private var email = ""
    @State private var pin1 = ""
    @State private var pin2 = ""
    @State private var pin3 = ""
    @State private var pin4 = ""
    @EnvironmentObject var router: Router
    
    //MARK: - View Modifiers -
    @FocusState private var focusedField: OTPField?
    //MARK: - Variables -
    
    
    
    var body: some View {
        ZStack{
            VStack{
                // MARK: - Heading and Sub-heading Section
                VStack(spacing: 5){
                    Text(Constants.EmailVerificationTitle.emailVerification)
                        .customFont(.medium, 30)
                    Text(Constants.EmailVerificationTitle.subheading)
                        .customFont(.regular, 14)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .center)
                
                HStack(alignment: .center, spacing: 16) {
                    OTPTextField(text: $pin1, focusedField: $focusedField, currentField: .pin1, nextField: .pin2)
                    OTPTextField(text: $pin2, focusedField: $focusedField, currentField: .pin2, nextField: .pin3, previousField: .pin1)
                    OTPTextField(text: $pin3, focusedField: $focusedField, currentField: .pin3, nextField: .pin4, previousField: .pin2)
                    OTPTextField(text: $pin4, focusedField: $focusedField, currentField: .pin4, previousField: .pin3)
                }.padding()

                // MARK: - Resend Otp
                HStack{
                   
                    Text(Constants.EmailVerificationTitle.resendOtp)
                        .customFont(.medium, 15)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .underline()
                        .foregroundStyle(.pinkAccent)
                }.onTapGesture {
                    HapticFeedbackHelper.lightImpact()
                    router.navigate(to: .forgotPassword)
                }
                .padding(.trailing, 10)
                .padding(.top, 5)
                
                Spacer()
                
                // MARK: - SendOtp Button
                VStack{
                    CustomButton(
                        title: Constants.EmailVerificationTitle.verify,
                        action: {
                            router.navigate(to: .createNewPassword)
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                }
            }.padding(.horizontal, 20)
                .padding(.top, 20)
                .onAppear{
                    
                }
        }.background(.backgroundTheme)
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: {
                        router.authNavigateBack()
                    })
                }
            }
            .onAppear {
                focusedField = .pin1
            }

    }
}

#Preview {
    EmailVerificationView()
}


struct OTPTextField: View {
    @Binding var text: String
    var focusedField: FocusState<OTPField?>.Binding
    let currentField: OTPField
    var nextField: OTPField?
    var previousField: OTPField?

    var body: some View {
        ZStack {
            // The TextField will be invisible but still focusable and editable
            TextField("", text: $text)
                .customFont(.medium, 20)
                .frame(width: 50, height: 50)
                .tint(.black)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .focused(focusedField, equals: currentField)
        }
        .onChange(of: text) { oldValue, newValue in
            print("we're in onchange block")
                
            // Ensure only 1 character in the text field
            if newValue.count > 1 {
                text = String(newValue.prefix(1)) // Ensure only 1 character
            }
                
            // Move to the next field if text is not empty
            if !newValue.isEmpty {
                if let next = nextField {
                    focusedField.wrappedValue = next
                }else{
                    focusedField.wrappedValue = nil
                }
            } else {
                // Move to the previous field if the text is empty
                if let previous = previousField {
                    focusedField.wrappedValue = previous
                }
            }
        }
        .overlay {
            let isFocused = (focusedField.wrappedValue == currentField)
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.primaryTheme : Color.gray, lineWidth: isFocused ? 3 : 2)
        }
    }
}
