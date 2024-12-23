//
//  BackButton.swift
//  SecurityGuard
//
//  Created by Sunfocus Solutions on 14/11/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    var action: (() -> Void)?
    var body: some View {
        Image(.arrowBack)
            .resizable()
            .frame(width: 26 , height: 26)
            .onTapGesture {
                HapticFeedbackHelper.lightImpact()
                action?() ?? dismiss()
            }
            .padding(.leading, 0)
    }
}
