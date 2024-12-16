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
            ZStack {
                VStack {
                    Image(.google)
                        .resizable()
                        .frame(width: 64, height: 64)
                    Text("We’re so happy that you decided to join CoachWise!")
                        .customFont(.medium, 16)
                        .multilineTextAlignment(.center)
                        .padding(.top, 12)
                    Text("We’ve just sent an email to")
                        .customFont(.regular, 12)
                        .padding(.top, 15)
                    VStack(spacing: 6) {
                        Text(email)
                            .customFont(.medium, 16)
                            .foregroundStyle(.primaryTheme)
                        Text("Just click on the link in that email to verify your account & return to login screen to complete your sign-up.")
                            .customFont(.regular, 14)
                            .multilineTextAlignment(.center)
                    }.padding(.top, 6)
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
                    }.padding(.top, 12)
                }
            }.background(.backgroundTheme)
                .padding(.horizontal, 50)
        }.background(.clear)
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    JoiningPopUpView()
}
