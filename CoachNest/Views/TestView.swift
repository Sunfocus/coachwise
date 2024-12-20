//
//  TestView.swift
//  CoachNest
//
//  Created by ios on 20/12/24.
//

import SwiftUI

struct TestView: View {
    @State private var email = ""
    
    var body: some View {
        ZStack{
            VStack{
            //    CustomTextField(title: "Email",placeholder: "Enter your email",text: $email)
                TextField("name", text: $email)
                .padding()
                Spacer()
                // MARK: - Login Button
                VStack{
                    CustomButton(
                        title: Constants.SignUpViewTitle.logIn,
                        action: {
                            HapticFeedbackHelper.mediumImpact()
                        }
                    )
                }
                .padding()
            }
        }
    }
}

#Preview {
    TestView()
}
