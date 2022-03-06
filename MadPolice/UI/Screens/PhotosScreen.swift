//
//  PhotosScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI

struct PhotosScreen: View {
    
    var uiImages = [UIImage]()
    
    @State private var selection: String? = nil
    @State var selectionImage: UIImage = UIImage(named: "Logo")!
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(photos: [CriminalImagesModel]) {
        self.uiImages = linksToImages(links: photos)
    }
    
    var body: some View {
        VStack{
        
            HeaderNav(title: "Photos", optionBUtton: 0)
            
            NavigationLink(destination: ShowPhotoScreen(images: uiImages, selectedTabFromView: $selectionImage).navigationBarHidden(true), tag: "ShowPhotoScreen", selection: $selection) { EmptyView() }
            
            ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(uiImages, id: \.self) { item in
                    Button(action: {
                        selectionImage = item
                        selection = "ShowPhotoScreen"
                    }){
                        Image(uiImage: item)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 68, height: 68)
                }
            }
            }
        }
    }
    
    func linksToImages(links: [CriminalImagesModel]) -> [UIImage]{
        
        var toRet = [UIImage]()
        
        for i in 0..<links.count {
            
            let url = URL(string: links[i].link)!
            let data = try! Data(contentsOf: url)
            toRet.append(UIImage(data: data) ?? UIImage(named: "Logo")!)
        }
        
        return toRet
        
    }
}

