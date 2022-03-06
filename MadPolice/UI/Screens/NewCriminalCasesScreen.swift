//
//  NewCriminalCasesScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI

struct NewCriminalCasesScreen: View, actionHeaderView {
    
    @State private var isShowDescription = false
    @State private var numberContent: String = ""
    @State private var dateContent: String = ""
    @State private var detectiveContent: String = ""
    @State private var clientContent: String = ""
    @State private var description: String = ""
    @State private var counterDescription = "0"
    
    @State private var criminalCasesToSend: CriminalSubModel = CriminalSubModel(id: "", category: "", detective: "", client: "", number: "", description: "", create_date: "", images: [CriminalImagesModel]())
    
    var body: some View {
        VStack{
            HeaderNav(titleStr: "New Criminal Cases", actionProtocol: self, optionButton: 4)
            
            CustomTextFieldControl(title: "Number:", content: $numberContent)
                .padding(.horizontal, 16)
                .onChange(of: numberContent) { newValue in
                    self.numberContent = newValue
                    self.criminalCasesToSend.number = newValue
                }
            
            CustomTextFieldControl(title: "Date:", content: $dateContent)
                .padding(.horizontal, 16)
                .onChange(of: dateContent) { newValue in
                    self.dateContent = newValue
                    self.criminalCasesToSend.create_date = newValue
                }
            
            CustomTextFieldControl(title: "Detective:", content: $detectiveContent)
                .padding(.horizontal, 16)
                .onChange(of: detectiveContent) { newValue in
                    self.detectiveContent = newValue
                    self.criminalCasesToSend.detective = newValue
                }
            
            CustomTextFieldControl(title: "Client:", content: $clientContent)
                .padding(.horizontal, 16)
                .onChange(of: clientContent) { newValue in
                    self.clientContent = newValue
                    self.criminalCasesToSend.client = newValue
                }
            
            Text("Category:")
                .font(.custom("Roboto-Regular", size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            Button(action: {}){
                HStack {
                    Text("Robery")
                        .font(.custom("Roboto-Regular", size: 16))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    ZStack{
                        Image(systemName: "chevron.up")
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
            .border(.gray)
            
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
                            self.criminalCasesToSend.description = newValue
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
            .padding(.horizontal, 16)
            
            Spacer()
        }
    }
    
    func addPhoto() {
        
    }
    
    func sharePhoto(uiImage: UIImage) {
        
    }
    
    func deleteItem() {
        
    }
    
    func addItem() {
        Api().postCriminalCase(model: criminalCasesToSend)
        
    }
}

struct NewCriminalCasesScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewCriminalCasesScreen()
    }
}

