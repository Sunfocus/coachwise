//
//  CreateNewPassword.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 17/12/24.
//

import SwiftUI

struct CreateNewPassword: View {
    //MARK: - @State variables -
    @State private var password = ""
    @State private var confirmPassword = ""
    @FocusState private var focusField: Field?
    @EnvironmentObject var router: Router
    
    //MARK: - Variables -
    enum Field: Hashable {
        case password, confirmPassword
    }
    
    var body: some View {
        ZStack{
            VStack{
                // MARK: - Back Button Section
                HStack {
                    Image(.arrowBack)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            router.authNavigateBack()
                        }
                    Spacer()
                }
                
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
                    SecureTextField(title: Constants.TextField.Title.password,
                                    placeholder: Constants.TextField.Placeholder.password,
                                    text: $password,
                                    isSecureText: true,
                                    buttonType: .next,
                                    onSubmit: {
                        print("Final field submitted")
                    })
                    .focused($focusField, equals: .password)
                    SecureTextField(title: Constants.TextField.Title.confirmPassword,
                                    placeholder: Constants.TextField.Placeholder.confirmPassword,
                                    text: $confirmPassword,
                                    isSecureText: true,
                                    buttonType: .done,
                                    onSubmit: {
                        print("Final field submitted")
                    })
                    .focused($focusField, equals: .confirmPassword)
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
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
    }
}

#Preview {
    CreateNewPassword()
}
