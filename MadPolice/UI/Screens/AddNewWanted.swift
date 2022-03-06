//
//  AddNewWanted.swift
//  MadPolice
//
//  Created by Денис Большачков on 04.03.2022.
//

import SwiftUI

struct AddOrEditNewWantedScreen: View {
    
    @State private var status: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var middleName: String = ""
    @State private var nickName: String = ""
    @State private var lastLocation: String = ""
    @State private var description: String = ""
    
    @State private var counterDescription: String = "0"
    
    //image picker data
    @State private var showImagePicker = false
    @State private var showActionSceet = false
    @State private var image: Image?
    @State private var sourceType = 0
    
    var body: some View {
        ZStack {
        VStack {
            HeaderNav(title: "Wanted", optionBUtton: 0)
            
            HStack (alignment: .top){
                
                ZStack{
                    
                    Circle()
                        .fill(.gray)
                        .frame(width: 140, height: 140)
                        .padding(.leading, 23)
                        .padding(.top, 11)
                    
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .padding(.leading, 23)
                        .padding(.top, 11)
                    
                    Button(action: {
                        showActionSceet.toggle()
                    }){
                        Image("Add Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 24, height: 24)
                    .offset(x: 70, y: 70)
                }
                
                VStack{
                    CustomTextFieldControl(title: "Status:", content: $status)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 23)
                        .padding(.trailing, 23.7)
                    
                    CustomTextFieldControl(title: "Firstname:", content: $firstName)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 23)
                        .padding(.trailing, 23.7)
                        .padding(.top, 7)
                    
                    CustomTextFieldControl(title: "Lastname:", content: $lastName)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 23)
                        .padding(.trailing, 23.7)
                        .padding(.top, 7)
                }
                
            }
            
            HStack {
                CustomTextFieldControl(title: "Nicknames:", content: $nickName)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 23)
                
                CustomTextFieldControl(title: "Middlename:", content: $middleName)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 23.7)
            }
            
            CustomTextFieldControl(title: "Last location:", content: $lastLocation)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 23.7)
                .padding(.top, 17)
            
            
            VStack (alignment: .leading) {
                Text("Description:")
                    .font(.custom("Roboto-Regular", size: 16))
                
                
                TextField("description", text: $description)
                    .font(.custom("Roboto-Regular", size: 16))
                    .padding(.top, 4)
                    .frame(maxWidth: 316)
                    .onChange(of: description) { newValue in
                        if (newValue.count <= 255){
                            description = newValue
                            counterDescription = String(newValue.count)
                        }
                    }
                    
                
                
                Divider()
                    .frame(height: 2)
                    .background(Color(#colorLiteral(red: 0, green: 0.4992540479, blue: 0.5453501344, alpha: 1)))
                    .padding(.top, 4)
                
                Text(counterDescription + " / 255")
                    .font(.custom("Roboto-Regular", size: 12))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 23)
            .padding(.trailing, 24)
            
            
            Spacer()
        }
        .actionSheet(isPresented: $showActionSceet, content: {() -> ActionSheet in
            ActionSheet(title: Text("Select Image"), message: Text("Please select an image from the image or use the camera"), buttons: [
                ActionSheet.Button.default(Text("Camera"), action: {
                    self.sourceType = 0
                    showImagePicker.toggle()
                }),
                ActionSheet.Button.default(Text("Photo gallery"), action: {
                    self.sourceType = 1
                    showImagePicker.toggle()
                }),
                ActionSheet.Button.cancel()
            ])
        })
            
            
            if showImagePicker {
                ImagePicker(isVisible: $showImagePicker, image: $image, sourceType: sourceType)
            }
        }
        
    }
}

struct AddNewWantedScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddOrEditNewWantedScreen()
    }
}


