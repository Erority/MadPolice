//
//  ShowPhotoScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI

struct ShowPhotoScreen: View {
    
    var images: [UIImage]
    @Binding var selectedTabFromView: UIImage
    
    init(images: [UIImage], selectedTabFromView: Binding<UIImage>){
        self.images = images
        self._selectedTabFromView = selectedTabFromView
        
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(#colorLiteral(red: 1, green: 0.2653175294, blue: 0, alpha: 1))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(#colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1))
        UIPageControl.appearance().tintColor = UIColor(#colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1))
    }
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {}){
                    Image("Back Arrow")
                }
                .frame(width: 24, height: 24)
                .padding(.leading, 17)
                
                Spacer()
                
                Button(action: {}){
                    Image("Delete Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 24, height: 24)
                .padding(.trailing, 15)
            }
            
            TabView (selection: $selectedTabFromView){
                ForEach (images, id: \.self) { img in
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .tag(img)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }.background(.black)
    }
}
