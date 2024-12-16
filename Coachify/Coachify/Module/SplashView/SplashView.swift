//
//  SplashView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 13/12/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            if isActive {
                if router.isUserLoggedIn {
                    LoginView()
                } else {
                    LoginView()
                }
            } else {
                // Splash screen content
                Image(.google)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(.rect(cornerRadius: 20))
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
