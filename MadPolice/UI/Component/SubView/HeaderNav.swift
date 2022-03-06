//
//  HeaderNav.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct HeaderNav: View {
    
    var title: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var optionButton: Int = 0
    @State private var presentShareSheet: Bool = false
    @State var items: [Any] = []
    
    @State var imageToSave: UIImage? = nil
    @State private var selection: String? = nil
    
    var actionProtocol: actionHeaderView?
    
    var sharePhotoI: sharePhotoToHeader?
    
    
    init (title: String, optionBUtton: Int) {
        self.title = title
        self.optionButton = optionBUtton
    }
    
    init (titleStr: String, actionProtocol: actionHeaderView, optionButton: Int){
        self.title = titleStr
        self.actionProtocol = actionProtocol
        self.optionButton = optionButton
    }
    
    init (titleStr: String, sharePhoto: sharePhotoToHeader, optionBUtton: Int){
        self.title = titleStr
        self.sharePhotoI = sharePhoto
        self.optionButton = optionBUtton
    }
    
    var body: some View {
        ZStack{
            
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image("Back Arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            
            Text(title)
                .font(.custom("Calibri Regualr", size: 22))
                .foregroundColor(.white)
            
            Spacer()
            
            switch optionButton {
            case 0:
                EmptyView()
                
            case 1:
                HStack {
                    Spacer()
                    
                    Button(action: {
                        selection = "NewPhotoRobotScreen"
                    }){
                        Image("IconAdd")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                    }
                    .padding(.trailing, 23)
                }
                .frame(maxWidth: .infinity)
                
            case 2:
                HStack {
                    Spacer()
                    
                    Button(action: {
                        sharePhotoI!.share()
                    }) {
                        Image("IconShare")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 19.9)
                    }
                    .padding(.trailing, 23)
                }
                .frame(maxWidth: .infinity)
            case 3:
                HStack {
                    Spacer()
                    
                    HStack (spacing: 0){
                        Button(action: {
                            actionProtocol?.deleteItem()
                        }){
                            Image("Delete Icon")
                        }.frame(width: 24, height: 24)
                        
                        Button(action: {
                            actionProtocol?.addItem()
                        }){
                            Image("IconAdd")
                        }.frame(width: 24, height: 24)
                    }.padding(.trailing, 20)
                }
            case 4:
                HStack {
                    Spacer()
                    
                    Button(action: {
                        actionProtocol?.addItem()
                    }) {
                        Image("Check Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 19.9)
                    }
                    .padding(.trailing, 23)
                    
                }
                
            default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 39)
        .background(Color(#colorLiteral(red: 0, green: 0.4992540479, blue: 0.5453501344, alpha: 1)))
        
    }
}


protocol actionHeaderView {
    func addPhoto()
    func sharePhoto(uiImage: UIImage)
    func deleteItem()
    func addItem()
}


protocol sharePhotoToHeader {
    func share ()
}
