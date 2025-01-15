//
//  NewMemoriesDataView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 27/12/24.
//

import SwiftUI

// MARK: - New Memories Component View
struct NewMemoriesDataView: View {
    let memories: [String]?
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(1))]) {
                    ForEach(memories!, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(12)
                            .padding(8) // Inner padding for the content
                            .background(Color.darkGreyBackground) // Ensure this is a defined color
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
                            .padding(.trailing, 5)
                        
                    }
                }
                .padding(.vertical, 3) // Add space to the top and bottom for the shadow
            }  .safeAreaPadding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
        }
        .padding(.bottom, 12)
    }
}
