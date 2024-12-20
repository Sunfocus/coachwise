//
//  LoginView.swift
//  Coachify
//
//  Created by ios on 13/12/24.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - @State variables -
    @State private var email = ""
    @State private var password = ""
    
    //MARK: - View Modifiers -
    @EnvironmentObject var router: Router
    @FocusState private var focusField: Field?
    
    //MARK: - Variables -
    enum Field: Hashable {
        case email, pass
    }
    
    var body: some View {
        ZStack{
            VStack{
                // MARK: - Heading and Sub-heading Section
                VStack(spacing: 5){
                    Text(Constants.LogInViewTitle.welcomeBack)
                        .customFont(.medium, 30)
                    Text(Constants.LogInViewTitle.logInContinue)
                        .customFont(.regular, 14)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.top, 50)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                
                // MARK: - Email and Password Section
                VStack(spacing: 10){
                    CustomTextField(title: Constants.TextField.Title.email,
                                    placeholder: Constants.TextField.Placeholder.email,
                                    text: $email,
                                    buttonType: .next,
                                    onSubmit: {
                        focusField = .pass
                    } )
                    .focused($focusField, equals: .email)
                    
                    SecureTextField(title: Constants.TextField.Title.password,
                                    placeholder: Constants.TextField.Placeholder.password,
                                    text: $password,
                                    isSecureText: true,
                                    buttonType: .done,
                                    onSubmit: {
                        print("Final field submitted")
                    })
                    .focused($focusField, equals: .pass)
                    
                    HStack{
                        Text(Constants.LogInViewTitle.forgotPassword)
                            .customFont(.medium, 14)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .underline()
                            .foregroundStyle(.pinkAccent.opacity(0.7))
                            .onTapGesture {
                                HapticFeedbackHelper.lightImpact()
                                router.navigate(to: .forgotPassword)
                            }
                    }
                }
                
                // MARK: - Login Button
                VStack{
                    CustomButton(
                        title: Constants.SignUpViewTitle.logIn,
                        action: {
                            HapticFeedbackHelper.lightImpact()
                        }
                    )
                }
                .padding(.top)
                
                // MARK: - Or Sign In With
                HStack {
                    VStack{
                        Divider()
                            .frame(height: 0.3)
                            .background(.gray)
                            .padding(.trailing, 10)
                    }
                    Text(Constants.SignUpViewTitle.or)
                        .customFont(.regular, 15)
                        .layoutPriority(1)
                    
                    VStack {
                        Divider()
                            .frame(height: 0.3)
                            .background(.gray)
                            .padding(.leading, 10)
                    }
                }
                .padding(.top, 10)
                
                // MARK: - Google and Apple Login Section
                HStack(spacing: 20){
                    Image(.google)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        }
                        .onTapGesture {
                            print("google Sign-in")
                        }
                    Image(.apple)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .padding(11)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        }
                        .onTapGesture {
                            print("apple Sign-in")
                        }
                }
                
                Spacer()
                
                // MARK: - Don't have an account? - Sign Up Section
                HStack {
                    Text(Constants.LogInViewTitle.dontHaveAccount)
                        .customFont(.regular, 16)
                    Button(action: {
                        HapticFeedbackHelper.lightImpact()
                    }, label: {
                        Text(Constants.LogInViewTitle.signUp)
                            .underline()
                            .customFont(.semiBold, 16)
                            .foregroundColor(.pinkAccent)
                            .onTapGesture {
                                HapticFeedbackHelper.lightImpact()
                                router.authNavigateBack()
                            }
                    })
                }
            }
        }.padding(.horizontal, 20)
            .background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
    }
}

#Preview {
    LoginView()
}

