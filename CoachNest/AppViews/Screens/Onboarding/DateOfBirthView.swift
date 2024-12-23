//
//  DateOfBirthView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 20/12/24.
//

import SwiftUI

struct DateOfBirthView: View {
    
    @EnvironmentObject var router: Router
    @State private var date = Date.now

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text(Constants.DateOfBirthView.enterDob)
                        .customFont(.semiBold, 24)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(Constants.DateOfBirthView.dobMessage)
                        .customFont(.regular, 14)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }.padding(.horizontal, 20)
                // MARK: - Date Of Birth Selection
                VStack {
                    HStack {
                        Text(Constants.DateOfBirthView.dob)
                            .customFont(.regular, 14)
                        Spacer()
                        DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                            .colorInvert()
                            .colorMultiply(.primaryTheme)
                            .tint(.primaryTheme)
                    }
                }.padding(.top, 30)
                    .padding(.horizontal, 30)
                Spacer()
                // MARK: - Next Button
                VStack{
                    CustomButton(
                        title: Constants.DateOfBirthView.next,
                        action: {
                            router.navigate(to: .joinGroupView)
                        }
                    )
                }.padding(.horizontal, 20)
            }.padding(.top, 20)
        }.background(.backgroundTheme)
            .navigationBarBackButtonHidden(true)
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
    DateOfBirthView()
}
