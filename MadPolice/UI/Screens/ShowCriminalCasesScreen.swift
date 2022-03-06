//
//  ShowCriminalCasesScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI

struct ShowCriminalCasesScreen: View {
    
    @State private var isShowDescription = false
    @Binding var model: CriminalSubModel
    
    @State private var selection: String? = nil
    
    var body: some View {
        VStack {
            HeaderNav(title: "Show Criminal cases", optionBUtton: 0)
            
            
            DescriptionSubView(title: "Number:", content: model.number)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .padding(.top, 12)
            
            DescriptionSubView(title: "Date:", content: model.create_date)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .padding(.top, 12)
            
            DescriptionSubView(title: "Client:", content: model.client)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .padding(.top, 12)
            
            DescriptionSubView(title: "Category:", content: model.category)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .padding(.top, 12)
            
            DescriptionSubView(title: "Detective:", content: model.detective)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .padding(.top, 12)
            
            Button(action: {
                isShowDescription.toggle()
            }){
                HStack {
                    Text("Description")
                        .font(.custom("Roboto-Regular", size: 16))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    ZStack{
                        Image(systemName: isShowDescription ? "chevron.up" : "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .frame(width: 24, height: 24)
                    .border(.gray)
                    .padding(.trailing, 16)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.leading, 24)
            
            if isShowDescription {
                Text(model.description)
                    .font(.custom("Roboto-Regular", size: 16))
                    .foregroundColor(.black)
                    .padding(.trailing, 29)
                    .padding(.leading, 25)
            }
            
            Text("Show Materials:")
                .font(.custom("Roboto-Regular", size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .padding(.top, 43)
            
            VStack {
                
                NavigationLink(destination: PhotosScreen(photos: model.images ).navigationBarHidden(true), tag: "PhotosOfCriminalCases", selection: $selection) { EmptyView() }
                
                Button(action: {}){
                    HStack (spacing: 10 ){
                        Image("FolderExtends")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                        
                        Text("Eindence")
                            .font(.custom("Roboto-Regular", size: 16))
                            .foregroundColor(.black)
                    }}
                .frame(height: 56)
                
                Button(action: {
                    selection = "PhotosOfCriminalCases"
                }){
                    HStack (spacing: 10 ){
                        Image("FolderImages")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                        
                        Text("Photos")
                            .font(.custom("Roboto-Regular", size: 16))
                            .foregroundColor(.black)
                    }}
                .frame(height: 56)
                
                Button(action: {}){
                    HStack (spacing: 10 ){
                        Image("FolderMusic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                        
                        Text("Audio")
                            .font(.custom("Roboto-Regular", size: 16))
                            .foregroundColor(.black)
                    }
                }.frame(height: 56)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
        }
    }
}


//private struct MaterialItem: View {
//
//    var img: Image
//    var text: Text
//
//    init(model: CriminalImagesModel){
//        let url = URL(string: model.link)!
//        let dataImg = try!  Data(contentsOf: url)
//        let uiImage = UIImage(data: dataImg)
//        img = Image(uiImage: uiImage ?? UIImage(named: "Logo")!)
//        text = Text(model.title)
//    }
//
//    var body: some View {
//        HStack (spacing: 10) {
//            img
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 24, height: 24)
//
//            Text("fdasfds")
//                .font(.custom("Roboto-Regular", size: 16))
//                .foregroundColor(.black)
//
//        }
//    }
//}

private struct DescriptionSubView: View {
    var title: String
    var content: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.custom("Roboto-Regular", size: 16))
            
            Text(content)
                .font(.custom("Roboto-Regular", size: 16))
        }
    }
}
