//
//  ContentView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 12/12/24.
//

import SwiftUI

struct SignUpView: View {
    
    //MARK: - @State variables
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isTermsAccepted: Bool = false
    
    //MARK: - View Modifiers -
    @FocusState private var focusedField: Field?
    @EnvironmentObject var router: Router
    //MARK: - Variables -
    enum Field: Hashable {
        case email, firstName, lastName, phoneNumber, password
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(Constants.SignUpViewTitle.createAccount)
                    .customFont(.medium, 32)
                Text(Constants.SignUpViewTitle.joinUs)
                    .customFont(.regular, 14)
                Spacer()
                
                ScrollView {
                    VStack(spacing: 10) {
                        CustomTextField(title: Constants.TextField.Title.firstName,
                                        placeholder: Constants.TextField.Placeholder.firstName,
                                        text: $firstName,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .lastName
                                        })
                        .focused($focusedField, equals: .firstName)
                        
                        CustomTextField(title: Constants.TextField.Title.lastName,
                                        placeholder: Constants.TextField.Placeholder.lastName,
                                        text: $lastName,
                                        buttonType: .next,
                                        onSubmit: {
                            focusedField = .email
                                        })
                        .focused($focusedField, equals: .lastName)
                        
                        CustomTextField(title: Constants.TextField.Title.email,
                                        placeholder: Constants.TextField.Placeholder.email,
                                        text: $email,
                                        buttonType: .next,
                                        keyboardType: .emailAddress,
                                        onSubmit: {
                            focusedField = .password
                                        })
                        .focused($focusedField, equals: .email)
                        
                        SecureTextField(title: Constants.TextField.Title.password,
                                        placeholder: Constants.TextField.Placeholder.password,
                                        text: $password,
                                        isSecureText: true,
                                        buttonType: .done,
                                        onSubmit: {
                            print("Final field submitted")
                        })
                        .focused($focusedField, equals: .password)
                    }.padding(.horizontal, 1)
                    // MARK: - Agree to the Terms Of Service
                    VStack {
                        HStack{
                            Image(isTermsAccepted ? .checkboxFill : .checkboxEmpty)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .onTapGesture {
                                    isTermsAccepted.toggle()
                                }
                            HStack(spacing: 0) {
                                Text(Constants.SignUpViewTitle.agreeTo)
                                    .customFont(.regular, 12)
                                Text(Constants.SignUpViewTitle.termsOfService)
                                    .underline()
                                    .customFont(.semiBold, 12)
                                Text(Constants.SignUpViewTitle.and)
                                    .customFont(.regular, 12)
                                Text(Constants.SignUpViewTitle.privacyPolicy)
                                    .underline()
                                    .customFont(.semiBold, 12)
                            }
                            
                            Spacer()
                        }
                    }.padding(.top, 12)
                    
                    // MARK: - Sign Up Button
                    VStack{
                        CustomButton(
                            title: Constants.SignUpViewTitle.signUpButtonText,
                            action: {
                                HapticFeedbackHelper.mediumImpact()
                                print("On Tap SignUp")
                                router.navigate(to: .enrollmentType)
                            }
                        )
                    }.padding(.top, 25)
                    
                    // MARK: - Or Sign In With
                    VStack(spacing: 25) {
                        HStack {
                            VStack{
                                Divider()
                                    .frame(height: 1)
                                    .background(.gray)
                                    .padding(.trailing, 10) // Apply padding to control divider spacing
                            }
                            Text(Constants.SignUpViewTitle.or)
                                .customFont(.regular, 15)
                                .layoutPriority(1) // Gives the text higher priority to stay on one line
                            VStack {
                                Divider()
                                    .frame(height: 1)
                                    .background(.gray)
                                    .padding(.leading, 10)
                            }
                        }
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
                    }.padding(.top, 12)
                    // MARK: - Don't have an account? - Sign Up
                    HStack {
                        Text(Constants.SignUpViewTitle.alreadyHaveAnAccount)
                            .customFont(.regular, 14)
                        Button(action: {
                            print("SignIn Click")
                            router.navigate(to: .login)
                            HapticFeedbackHelper.lightImpact()
                        }, label: {
                            Text(Constants.SignUpViewTitle.logIn)
                                .underline()
                                .customFont(.semiBold, 16)
                                .foregroundStyle(.pink)
                        })
                    }.padding(.top, 40)
                }.scrollIndicators(.hidden)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }.padding(.top, 20)
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
    }
}

#Preview {
    SignUpView()
}
