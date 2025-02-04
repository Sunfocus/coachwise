//
//  JoiningPopUpView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 13/12/24.
//

import SwiftUI

struct JoiningPopUpView: View {
    @State private var email = "bill.sanders@example.com"
    var body: some View {
        ZStack {
            Color.clear
            ZStack {
                VStack {
                    // MARK: - Image
                    Image(.doubleCheck)
                        .resizable()
                        .frame(width: 64, height: 64)
                        .padding(.top, 20)
                    Text("We’re so happy that you decided to join CoachWise!")
                        .customFont(.medium, 16)
                        .multilineTextAlignment(.center)
                        .padding(.top, 12)
                    Text("We’ve just sent an email to")
                        .customFont(.regular, 12)
                        .padding(.top, 15)
                    // MARK: - Email & Verify email message
                    VStack(spacing: 6) {
                        Text(email)
                            .customFont(.medium, 16)
                            .foregroundStyle(.primaryTheme)
                        Text("Just click on the link in that email to verify your account & return to login screen to complete your sign-up.")
                            .customFont(.regular, 14)
                            .multilineTextAlignment(.center)
                    }.padding(.top, 6)
                    // MARK: - Horizontal Divider & Check to spam content
                    VStack(spacing: 12) {
                        HStack {
                            Spacer()
                            VStack {
                                Divider()
                                    .frame(width: 150, height: 1)
                                    .background(.gray)
                            }
                            Spacer()
                        }
                        Text("If you don’t see the email, you may need to check your spam folder.")
                            .customFont(.regular, 14)
                            .multilineTextAlignment(.center)
                        HStack {
                            VStack {
                                Divider()
                                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 1)
                                    .background(.gray)
                            }
                        }
                    }.padding(.top, 12)
                    // MARK: - Continue Button
                    VStack {
                        Button(action: {
                            print("On Tap Continue")
                        }, label: {
                            Text("Continue")
                                .customFont(.medium, 16)
                                .foregroundStyle(.primaryTheme)
                        })
                    }.padding(.top, 12)
                        .padding(.bottom, 12)
                }.padding(.horizontal, 15)
            }.background(.backgroundTheme)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 50)
        }/*.background(.clear)*/
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    JoiningPopUpView()
}
