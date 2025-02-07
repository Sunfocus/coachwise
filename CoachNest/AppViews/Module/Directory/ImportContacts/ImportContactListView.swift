//
//  ImportContactListView.swift
//  CoachNest
//
//  Created by Rahul Pathania on 05/02/25.
//

import SwiftUI

struct ImportContactListView: View {
    
    //MARK: - Variables -
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    @State var isImportSuccessStatusViewVisible: Bool = false
    @State private var showDocumentPicker = false
        @State private var selectedFileURL: URL?
    
    var contactsUploadSuccess = Constants.Directory.yourUploadWasSuccess
    var contactUploadFailed = Constants.Directory.uploadFailed
    var thankyou = Constants.Directory.thankyou
    var oops = Constants.Directory.oops
    
    var body: some View {
        ZStack{
            VStack{
                topNavView
                subtitleView
                uploadDocumentView
                coachnestSupportTeam
                CustomButton(title: Constants.Directory.uploadDocument) {
                    print("document upload started")
                    isImportSuccessStatusViewVisible = true
                }.padding(.horizontal)
                Spacer()
            }
            
            if isImportSuccessStatusViewVisible {
                Color.black.opacity(0.2) // Dim background
                    .edgesIgnoringSafeArea(.all)
                
                UploadStatusPopupView(isSuccess: true, title: thankyou , message: contactsUploadSuccess  , primaryButtonTitle: "Back to directory",primaryAction: {
                    dismiss()
                }, secondaryButtonTitle: nil, secondaryAction: nil)
            }
            
            
        }.navigationBarBackButtonHidden()
            .background(.backgroundTheme)
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker { url in
                    self.selectedFileURL = url
                    print(self.selectedFileURL ?? "url path not found")
                }
            }
    }
    
    //MARK: - Subviews -
    var topNavView: some View{
        ZStack{
            VStack{
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .customFont(.regular, 17)
                    }
                    
                    Spacer()
                }.padding([.horizontal, .vertical], 15)
                    .overlay {
                        HStack{
                            Text(Constants.Directory.import_)
                                .customFont(.medium, 18)
                        }
                    }
                Divider()
            }
            .background(.darkGreyBackground)
        }
    }
    var subtitleView: some View{
        VStack{
            Text(Constants.Directory.uploadContactList)
                .customFont(.medium, 15)
                .padding(.vertical, 10)
        }
    }
    var uploadDocumentView: some View{
        Button(action:{
            showDocumentPicker.toggle()
        }) {
            VStack {
                Image(.documentUpload)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(12)
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Text(Constants.Directory.selectDocument)
                    .customFont(.regular, 14)
                    .padding(.bottom, 1)
                   
                Text(Constants.Directory.maxFileSize)
                    .customFont(.regular, 13)
            }
            .frame(height: 130)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 12.0, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 1.2,
                            dash: [7]
                        )
                    )
                    .foregroundColor(.primaryTheme)
            )
            .padding(.horizontal)
        }
    }
    var coachnestSupportTeam: some View{
        Text(Constants.Directory.coachnestTeamImportContacts)
            .customFont(.regular, 12)
            .multilineTextAlignment(.center)
            .padding([.horizontal, .top])
    }
}

#Preview {
    ImportContactListView()
}
