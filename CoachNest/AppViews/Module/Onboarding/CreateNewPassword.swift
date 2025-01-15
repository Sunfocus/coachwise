//
//  CreateNewPassword.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 17/12/24.
//

import SwiftUI

struct CreateNewPassword: View {
    @State private var resetPasswordViewModel = ResetPasswordViewModel()
    
    @FocusState private var focusField: Field?
    @EnvironmentObject var router: Router
    
    //MARK: - Variables -
    enum Field: Hashable {
        case password, confirmPassword
    }
    
    var body: some View {
        ZStack{
            VStack{
                // MARK: - Heading and Sub-heading Section
                VStack(spacing: 5){
                    Text(Constants.CreateNewPasswordViewTitle.createNewPassword)
                        .customFont(.medium, 30)
                    Text(Constants.CreateNewPasswordViewTitle.enterNewPasswordMessage)
                        .customFont(.regular, 14)
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .center)
                
             // MARK: - Password & Create Password TextFields
                VStack(spacing: 10){
                    SecureTextField(field: $resetPasswordViewModel.password,
                                    buttonType: .next,
                                    onSubmit: {
                        print("Final field submitted")
                    })
                    .focused($focusField, equals: .password)
                    .onChange(of: resetPasswordViewModel.password.value) { oldValue, newValue in
                        resetPasswordViewModel.validatePassword()
                    }
                    SecureTextField(field: $resetPasswordViewModel.confirmPassword,
                                    isSecureText: true,
                                    buttonType: .done,
                                    onSubmit: {
                        print("Final field submitted")
                    })
                    .focused($focusField, equals: .confirmPassword)
                    .onChange(of: resetPasswordViewModel.confirmPassword.value) { oldValue, newValue in
                        resetPasswordViewModel.validateConfirmPassword()
                    }
                }
                Spacer()
                // MARK: - Login Button
                VStack{
                    CustomButton(
                        title: Constants.CreateNewPasswordViewTitle.submit,
                        action: {
                            
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
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
    }
}

#Preview {
    CreateNewPassword()
}
