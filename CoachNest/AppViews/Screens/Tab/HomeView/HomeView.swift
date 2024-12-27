//
//  HomeView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        VStack(spacing:0){
            //Picker
            Text("Home View")
        }
    }
}

#Preview {
    HomeView()
}

extension UISegmentedControl {
  override open func didMoveToSuperview() {
     super.didMoveToSuperview()
     self.setContentHuggingPriority(.defaultLow, for: .vertical)
   }
}
