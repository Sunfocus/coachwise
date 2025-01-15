//
//  SplashView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 13/12/24.
//

import SwiftUI

//struct SplashView: View {
//    @State private var isActive: Bool = false
//    @EnvironmentObject var router: Router
//
//    var body: some View {
//        ZStack{
//            Color.primaryTheme
//                .ignoresSafeArea()
//            
//            VStack {
//                if isActive {
//                    if router.isUserLoggedIn {
//                        TabBarView()
//                            .onAppear{
//                                router.setRoot(to: .dashboard)
//                            }
//                    } else {
//                        LoginView()
//                            .onAppear{
//                                router.setRoot(to: .onboarding)
//                            }
//                    }
//                } else {
//                    // Splash screen content
//                    Image(.appLogo)
//                        .resizable()
//                        .frame(width: 200, height: 200)
//                        .clipShape(.rect(cornerRadius: 20))
//                        .ignoresSafeArea()
//                }
//            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//                    withAnimation {
//                        isActive = true
//                        router.isUserLoggedIn = true
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    SplashView()
//        .environmentObject(Router())
//}
