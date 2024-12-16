//
//  Router+Auth.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 21/11/24.
//

import SwiftUI

extension Router{
    @ViewBuilder
    func onboardDestination(for flow: AuthFlow) -> some View {
        switch flow{
        case .login:
            LoginView()
        case .signup:
            SignUpView()
        case .forgotPassword:
            SignUpView()
        }
    }
}

