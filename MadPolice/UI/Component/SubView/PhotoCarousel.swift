//
//  PhotoCarousel.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI


struct PhotoCarousel: View  {

    var images: [UIImage] = [UIImage]()
    
    @Binding var counter: Int
    @Binding var selectedTabFromView: UIImage
    
    
    init (substringToPhoto: String, selectedTab: Binding<UIImage>, counter: Binding<Int>){
        self.images = FilterPhotoRobotImages().filterTopPhotos(containsString: substringToPhoto)
        _selectedTabFromView = selectedTab
        _counter = counter
        
    }
    
    func next(){
        withAnimation {
            counter = counter < images.count ? counter + 1 : 0
            selectedTabFromView = images[counter]
            }
    }
    
    func previous(){
        withAnimation {
            counter = counter > 0 ? counter - 1 : 0
            selectedTabFromView = images[counter]
        }
    }
    
    
    var controls: some View {
        HStack {
            if counter > 0 {
                Button(action: {
                   previous()
                }) {
                    ZStack {
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 36.25, height: 36.25)
                        
                        
                        Image("Back Arrow")
                            .frame(width: 24, height: 24)
                            .padding(.leading, 12)
                    }
                }
                .offset(x: -13, y: 0)
                .edgesIgnoringSafeArea(.all)
            } else{
                EmptyView()
            }
            
            Spacer()
            
            if counter < images.count - 1 {
                Button(action: {
                    next()
                }) {
                    ZStack {
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 36.25, height: 36.25)
                        
                        
                        Image("Back Arrow")
                            .frame(width: 24, height: 24)
                            .padding(.leading, 12)
                            .rotationEffect(.degrees(180))
                    }
                }
                .offset(x: 13, y: 0)
                .edgesIgnoringSafeArea(.all)
            }
            else{
                EmptyView()
            }
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                TabView (selection: $selectedTabFromView){
                    ForEach (images, id: \.self) { img in
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .tag(img)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: selectedTabFromView) { newValue in
                    selectedTabFromView = newValue
                }
                .onAppear {
                    selectedTabFromView = images[counter]
                }
            }
            
            controls
        }
        .frame(height: 111)
            .frame(maxWidth:.infinity)
    }
    
}
