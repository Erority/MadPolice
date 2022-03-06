//
//  ShowWanted.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct ShowWantedScreen: View {
    
    @Binding var model: WantedSubModel?
    var img: Image? = nil
    
    init(bindModel: Binding<WantedSubModel?>){
        _model = bindModel
        
        if model != nil{
            
            let url = URL(string: model!.photo)!
            let dataImg = try! Data(contentsOf: url)
            let uiImg = UIImage(data: dataImg)
            
            img = Image(uiImage: uiImg!)
        }
    }
    
    var body: some View {
        VStack{
            HeaderNav(title: "Wanted", optionBUtton: 0)
            
            HStack (alignment: .top){
                
                img!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())
                    .padding(.leading, 23)
                    .padding(.top, 11)
                
                VStack{
                    WantedTextBlock(title: "Status:", content: model!.status)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 23)
                        .padding(.trailing, 23.7)
                    
                    WantedTextBlock(title: "Firstname:", content: model!.first_name)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 23)
                        .padding(.trailing, 23.7)
                        .padding(.top, 7)
                    
                    WantedTextBlock(title: "Lastname:", content: model!.last_name)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 23)
                        .padding(.trailing, 23.7)
                        .padding(.top, 7)
                }
                
            }
            
            HStack {
                WantedTextBlock(title: "Nicknames:", content: model!.nicknames)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 23)
                
                WantedTextBlock(title: "Middlename:", content: "none")
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 23.7)
            }
            
            WantedTextBlock(title: "Last location:", content: model!.last_location)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 23.7)
                .padding(.top, 17)
                
            VStack (alignment: .leading) {
                Text("Description:")
                    .font(.custom("Roboto-Regular", size: 16))
                
                
                Text(model!.description)
                        .font(.custom("Roboto-Regular", size: 16))
                        .padding(.top, 4)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 23)
            .padding(.trailing, 24)
            
            Spacer()
        }
    }
}



struct WantedTextBlock: View {
    
    var title: String
    var content: String
    
    var body: some View {
        VStack (alignment: .leading){
            Text(title)
                .font(.custom("Roboto-Regular", size: 16))
            
            Text(content)
                .font(.custom("Roboto-Regular", size: 16))
                .padding(.top, 3)
            
            Divider()
                .frame(height: 2)
                .background(Color(#colorLiteral(red: 0, green: 0.4992540479, blue: 0.5453501344, alpha: 1)))
                .padding(.top, 4)
            
        }
    }
}
