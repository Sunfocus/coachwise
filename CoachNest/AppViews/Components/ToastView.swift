//
//  ToastView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 06/02/25.
//

import SwiftUI

struct ToastView: View {
    var message: String
    var imageName: String
    var backgroundColor: Color = .primaryTheme
    
    var body: some View {
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.white)
                    .font(.title3)
                
                Text(message)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Spacer()
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 48)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.horizontal)
    }
}

// ✅ SwiftUI Preview
struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToastView(message: "Something went wrong!", imageName: "exclamationmark.triangle.fill")
        }
    }
}
