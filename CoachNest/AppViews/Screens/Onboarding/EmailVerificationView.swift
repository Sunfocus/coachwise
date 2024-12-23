//
//  EmailVerificationView.swift
//  Coachify
//
//  Created by ios on 13/12/24.
//

import SwiftUI

struct EmailVerificationView: View {
    
    //MARK: - @State variables -
    @State private var email = ""
    @EnvironmentObject var router: Router
    @State private var pin1 = ""
    @State private var pin2 = ""
    @State private var pin3 = ""
    @State private var pin4 = ""
    
    //MARK: - View Modifiers -
    @FocusState private var focusedField: Field?
    //MARK: - Variables -
    enum Field: Hashable {
        case pin1, pin2, pin3, pin4
    }
    
    
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
                
                // MARK: - Enter pin section
                HStack(alignment: .center, spacing: 20){
                    TextField("_", text: $pin1)
                        .customFont(.medium, 20)
                        .frame(width: 30, height: 30)
                        .keyboardType(.numberPad)
                        .padding()
                        .multilineTextAlignment(.center)
                        .focused($focusedField, equals: .pin1)
                        .onChange(of: pin1,{
                            
                            if pin1.count > 1 {
                                pin1 = String(pin1.prefix(1))
                            }
                            
                            
                            if pin1.isEmpty == false{
                                focusedField = .pin2
                            }else{
                                focusedField = .pin1
                            }
                        })
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        }
                    TextField("_", text: $pin2)
                        .customFont(.medium, 20)
                        .frame(width: 30, height: 30)
                        .padding()
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .pin2)
                        .onChange(of: pin2,{
                            if pin2.count > 1 {
                                pin2 = String(pin2.prefix(1))
                            }
                            
                            if pin2.isEmpty == false{
                                focusedField = .pin3
                            }else{
                                focusedField = .pin1
                            }
                            
                            
                            
                        })
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        }
                    TextField("_", text: $pin3)
                        .customFont(.medium, 20)
                        .multilineTextAlignment(.center)
                        .frame(width: 30, height: 30)
                        .padding()
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .pin3)
                        .onChange(of: pin3,{
                            if pin3.count > 1 {
                                pin3 = String(pin3.prefix(1))
                            }
                            
                            if pin3.isEmpty == false{
                                focusedField = .pin4
                            }else{
                                focusedField = .pin2
                            }
                         
                        })
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        }
                    TextField("_", text: $pin4)
                        .customFont(.medium, 20)
                        .frame(width: 30, height: 30)
                        .padding()
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .focused($focusedField, equals: .pin4)
                        .onChange(of: pin4,{
                            if pin4.count > 1 {
                                pin4 = String(pin4.prefix(1))
                            }
                            
                            if pin4.isEmpty == false{
                                focusedField = .pin4
                            }else{
                                focusedField = .pin3
                            }
                           
                        })
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 1)
                        }
                }
                
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
    EmailVerificationView()
}
