//
//  AddActivityView.swift
//  Coachify
//
//  Created by ios on 19/12/24.
//

import SwiftUI

struct AddActivityView: View {
    
    @State private var newActivity: String = ""
    @EnvironmentObject var viewModel: BusinessActivityViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack(spacing: -10){
                Spacer()
                Text("Add a new activity")
                    .customFont(.medium, 18)
                CustomTextField(title: "", placeholder: "Add Activity", text: $newActivity)
                    .padding()
                
                // MARK: - Next Button
                VStack{
                    CustomButton(
                        title: "Done",
                        action: {
                            viewModel.addActivity(title: newActivity)
                            if viewModel.showAlert == false{
                                dismiss()
                            }
                            
                        }
                    )
                }.padding(.horizontal, 20)
                    .padding(.top)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    AddActivityView()
}
