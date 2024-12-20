//
//  BusinessNameView.swift
//  Coachify
//
//  Created by Sunfocus Solutions on 18/12/24.
//

import SwiftUI

struct BusinessNameView: View {
    @EnvironmentObject var router: Router
    @State private var businessName: String = ""
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Back Button Section
                VStack {
                    HStack {
                        Image(.arrowBack)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                router.authNavigateBack()
                            }
                        Spacer()
                    }
                    // MARK: - Text Stack
                    VStack(alignment: .leading, spacing: 8) {
                        Text(Constants.BusinessNameViewTitle.whatIsBusinessName)
                            .customFont(.semiBold, 24)
                        Text(Constants.BusinessNameViewTitle.recognizeBusinessMessage)
                            .customFont(.regular, 14)
                    }.padding(.top, 10)
                
                   // MARK: - TextField
                    VStack(spacing: 8) {
                        CustomTextField(title: Constants.TextField.Title.yourBusinesName, placeholder: Constants.TextField.Placeholder.yourBusinesName, text: $businessName)
                        HStack {
                            Text(Constants.BusinessNameViewTitle.exampleBusinessName)
                                .customFont(.regular, 14)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    }.padding(.top, 24)
                    
                }.padding(.horizontal, 20)
                Spacer()
                // MARK: - Next Button
                VStack{
                    CustomButton(
                        title: Constants.JoiningEntryViewTitle.next,
                        action: {
                            router.navigate(to: .businessActivityView)
                        }
                    )
                }.padding(.horizontal, 20)
            }
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
    }
}

#Preview {
    BusinessNameView()
}
