//
//  ProfessionCell.swift
//  Coachify
//
//  Created by ios on 19/12/24.
//

import SwiftUI

struct ProfessionCell: View {
    
    //MARK: - Variables -  
    var imageName: UIImage = .selectedRadio
    var enrollment: EnrollmentData
    var selectedEnrollmentId: Int = 1
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(uiImage: imageName)
                .resizable()
                .frame(width: 24, height: 24)
            if enrollment.title == ""{
                Text(enrollment.subTitle)
                    .customFont(.regular, 16)
                    .lineSpacing(1.5)
               
            }else{
                VStack(alignment: .leading, spacing: 3){
                    Text(enrollment.title ?? "")
                        .customFont(.semiBold, 16)
                    Text(enrollment.subTitle)
                        .customFont(.regular, 16)
                }
            }
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(selectedEnrollmentId == enrollment.id ? .primaryTheme.opacity(0.2) : .white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(selectedEnrollmentId == enrollment.id ? .primaryTheme : .black.opacity(0.4), lineWidth: 0.6)
        )
    }
}

#Preview {
    let enrollment =  EnrollmentData(id: 1, title: Constants.JoiningEntryViewTitle.joinExistingClub, subTitle: Constants.JoiningEntryViewTitle.inviteCode, setImage: UIImage())
    ProfessionCell(imageName: UIImage(), enrollment: enrollment)
}
