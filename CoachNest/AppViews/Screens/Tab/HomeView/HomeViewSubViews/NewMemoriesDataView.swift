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
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(5)
                            .padding(.bottom, 2)
                            .background(.darkGreyBackground).clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            
                    }
                }
            }
        }.padding(.horizontal, 8)
            .padding(.bottom, 12)
    }
}
