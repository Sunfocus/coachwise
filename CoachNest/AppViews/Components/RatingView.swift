//
//  RatingView.swift
//  CoachNest
//
//  Created by ios on 15/01/25.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    let maxRating: Int
    let starSize: CGSize
    
    var body: some View {
        HStack(spacing: 4) {
            // Filled stars
            ForEach(0..<rating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: starSize.width, height: starSize.height)
                    .foregroundColor(.yellow)
            }
            // Empty stars
            ForEach(rating..<maxRating, id: \.self) { _ in
                Image(systemName: "star")
                    .resizable()
                    .frame(width: starSize.width, height: starSize.height)
                    .foregroundColor(.gray)
            }
            // Rating text
//            Text("(\(rating))")
//                .font(textFont)
//                .foregroundColor(.gray)
        }
    }
}



#Preview {
    RatingView(rating: 3, maxRating: 5, starSize: CGSize(width: 12, height: 12))
}
