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
                    .padding(.horizontal)
            }
        }
        .background(.backgroundTheme)
        .onChange(of: memoriesViewModel.photosPickerItems) { _, _ in
            Task{
                await memoriesViewModel.processMediaItems()
            }
        }
        .overlay(
            addMemoryButtonView
                .padding(.trailing, 30)
                .padding(.bottom, 40),
               alignment: .bottomTrailing
        )
        .sheet(isPresented: $memoriesViewModel.isImageSelected) {
            // Show enlarged image in a new sheet
            
            ZStack{
                if let item = memoriesViewModel.selectedItem{
                    if item.isVideo{
                        VideoPlayerView(videoURL: URL(string: item.videoUrl)!  )
                    }else{
                        ZStack{
                            Color.white.ignoresSafeArea()
                            VStack {
                                Image(uiImage: memoriesViewModel.selectedItem?.image ?? .sg1)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(20)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }.ignoresSafeArea()
                        }
                    }
                }
            }
           
        }//sheet end
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
            if memoriesViewModel.mediaItems.isEmpty{
                Spacer()
                noMemoriesView
                Spacer()
            }else{
                ImageGridView(viewModel: memoriesViewModel)
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
                maxSelectionCount: 50,
                matching:  .any(of: [.videos, .images]),
                preferredItemEncoding: .current
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
            .photosPickerStyle(.presentation)
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
    var addMemoryButtonView: some View {
        Group{
            if !memoriesViewModel.mediaItems.isEmpty{
                PhotosPicker(
                    selection: $memoriesViewModel.photosPickerItems,
                    maxSelectionCount: 50,
                    matching: .any(of: [.videos, .images])
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
                    viewModel.createGrid(mediaItems: viewModel.imagesAtEvenIndices())
                    Spacer()
                }
                VStack{
                    viewModel.createGrid(mediaItems: viewModel.imagesAtOddIndices())
                }.padding(.top, 40)
            }
        }.safeAreaPadding(EdgeInsets(top: 10, leading: 2, bottom: 80, trailing: 2))
                .scrollIndicators(.hidden)
    }
}



