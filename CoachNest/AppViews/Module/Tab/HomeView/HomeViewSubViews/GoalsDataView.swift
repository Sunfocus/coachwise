//
//  GoalsDataView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 27/12/24.
//

import SwiftUI

// MARK: - Goals Data View
struct GoalsDataView: View {
    let goalData: Goals
    var body: some View {
        VStack {
            HStack {
                Image(.sg1)
                    .clipShape(Circle())
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                VStack {
                    HStack {
                        Text(goalData.goalTitle ?? "-")
                            .customFont(.medium, 14)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    HStack {
                        Image(.sg1)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .clipShape(Circle())
                        Text(goalData.goalAchieverName ?? "-")
                            .customFont(.medium, 12)
                        Spacer()
                        Text("Update: \(goalData.lastUpdatedDate ?? "-")")
                            .customFont(.medium, 12)
                            .foregroundStyle(.gray)
                    }
                }
            }.padding(.horizontal, 10)
        }.background(.backgroundTheme)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 8)
    }
}
