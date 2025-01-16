//
//  MemoriesView.swift
//  CoachNest
//
//  Created by Sunfocus Solutions on 23/12/24.
//

import SwiftUI
import PhotosUI

struct MemoriesView: View {
    
    //MARK: - Variables -
    @Environment(\.presentSideMenu) var presentSideMenu
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    @StateObject private var memoriesViewModel = MemoriesViewModel()
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack{
            VStack{
                topHeaderView
                memories
            }.padding(.horizontal)
        }.onChange(of: memoriesViewModel.photosPickerItems) { _, _ in
            Task{
                for item in memoriesViewModel.photosPickerItems{
                    if let data = try? await item.loadTransferable(type: Data.self){
                        if let image = UIImage(data: data){
                            memoriesViewModel.images.append(image)
                        }
                        
                    }
                }
                memoriesViewModel.photosPickerItems = []
            }
        }
        .overlay(
            addScheduleButtonView
                .padding(.trailing, 30)
                .padding(.bottom, 40),
               alignment: .bottomTrailing
        )
    }
    
    //MARK: - Subviews -
    var topHeaderView: some View {
        //Tab Name menu icon filter and notification toggle Section
        VStack(spacing: 0){
            //Tab Name menu icon filter and notification toggle Section
            HStack {
                Image(.menuIcon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        //Open sidemenu
                        presentSideMenu.wrappedValue.toggle()
                    }
                Text("Memories")
                    .customFont(.semiBold, 24)
                Spacer()
                Image(.bell)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        router.navigate(to: .notificationView)
                    }
                    .padding(.trailing, 12)
                Image(.filterList)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                       
                    }
            }.padding([.horizontal, .vertical], 15)
            Divider()
        }
        .background(.darkGreyBackground)
    }
    var memories: some View{
        VStack{
            if memoriesViewModel.images.isEmpty{
                Spacer()
                noMemoriesView
                Spacer()
            }else{
                //SegmentControl
                segmentView
                switch selectedSegment{
                case 0:
                    ImageGridView(viewModel: memoriesViewModel)
                case 1:
                    ImageGridView(viewModel: memoriesViewModel)
                default:
                    ImageGridView(viewModel: memoriesViewModel)
                }
            }
        }
    }
    var noMemoriesView: some View{
        VStack{
            Spacer()
            Image(.memory)
                .resizable()
                .frame(width: 50, height: 50)
            Text("No Memories")
                .customFont(.medium, 16)
                .foregroundStyle(.primaryTheme)
            Text("There are currently no memories here")
                .customFont(.regular, 14)
                .multilineTextAlignment(.center)
            
            PhotosPicker(
                selection: $memoriesViewModel.photosPickerItems,
                maxSelectionCount: 50, // Max number of images to select
                matching: .images // Only allow images
            ) {
                Text("+  Add Memories")
                    .customFont(.medium, 14)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .tint(.primaryTheme)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primaryTheme, lineWidth: 1)
                    }
            }
            Spacer()
        }
    }
    var segmentView: some View{
        VStack{
            Picker("Select Option", selection: $selectedSegment) {
                Text("All").tag(0)
                Text("Favourites").tag(1)
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
        }
        .padding([.horizontal, .top])
    }
    var addScheduleButtonView: some View {
        
        Group{
            if !memoriesViewModel.images.isEmpty{
                PhotosPicker(
                    selection: $memoriesViewModel.photosPickerItems,
                    maxSelectionCount: 50, // Max number of images to select
                    matching: .images // Only allow images
                ) {
                    Circle()
                        .foregroundStyle(.primaryTheme)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(.memory)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .tint(.white)
                        }
                }
            }
        }
    }
}

#Preview {
    MemoriesView()
}

struct ImageGridView: View {
    @ObservedObject var viewModel: MemoriesViewModel
    var body: some View {
        ScrollView{
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                VStack{
                    viewModel.createGrid(images: viewModel.imagesAtOddIndices() )
                    Spacer()
                }
                VStack{
                    viewModel.createGrid(images: viewModel.imagesAtEvenIndices   () )
                    Spacer()
                }
            }
        }.scrollIndicators(.hidden)
    }
}



