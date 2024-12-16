//
//  ForgotPasswordView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 13/12/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    //MARK: - @State variables -
    @State private var email = ""
    @EnvironmentObject var router: Router
    
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
                    Text(Constants.ForgotPasswordViewTitle.forgotPassword)
                        .customFont(.medium, 30)
                    Text(Constants.ForgotPasswordViewTitle.subheading)
                        .customFont(.regular, 14)
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: 10){
                    CustomTextField(title: Constants.TextField.Title.email, placeholder: Constants.TextField.Placeholder.email, text: $email)
                    Text(Constants.ForgotPasswordViewTitle.otpToVerify)
                        .customFont(.regular, 14)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                // MARK: - Login Button
                VStack{
                    LoginButton(
                        title: Constants.ForgotPasswordViewTitle.sendOtp,
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
    ForgotPasswordView()
}
