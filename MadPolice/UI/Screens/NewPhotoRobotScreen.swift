//
//  NewPhotoRobotScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct NewPhotoRobotScreen: View, sharePhotoToHeader {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var presentShareSheet: Bool = false
    @State var items: [Any] = []
    
    @State private var topImg: UIImage = UIImage(named: "IconAdd")!
    @State private var midImg: UIImage = UIImage(named: "IconAdd")!
    @State private var botImg: UIImage = UIImage(named: "IconAdd")!
    
    @State private var topCounter: Int = 0
    @State private var midCounter: Int = 0
    @State private var botCounter: Int = 0
    
    private var isEdit: Bool = false
    @Binding private var editObject: PhotoRobot?
    
    init(editObject: Binding<PhotoRobot?>){
        isEdit = true
        self._editObject = editObject
    }
    
    var body: some View {
        ZStack{
            
            HeaderNav(titleStr: "NewPhotoRobots", sharePhoto: self, optionBUtton: 2)
                .frame(maxHeight: .infinity, alignment: .top)
            
            
            VStack (spacing: 0){
                PhotoCarousel(substringToPhoto: "top", selectedTab: $topImg, counter: $topCounter)
                PhotoCarousel(substringToPhoto: "middle", selectedTab: $midImg, counter: $midCounter)
                PhotoCarousel(substringToPhoto: "bottom", selectedTab: $botImg, counter: $botCounter)
                
                Button(action: {
                    if !isEdit{
                        let photoRobot = PhotoRobot(context: managedObjectContext)
                        let combineImg = ImageCombiner().combinePhotos(topImg, midImg, botImg)
                        
                        photoRobot.id = UUID()
                        photoRobot.botPosition = Int32(botCounter)
                        photoRobot.midPosition = Int32(midCounter)
                        photoRobot.topPosition = Int32(topCounter)
                        photoRobot.image = ImageConverter().convertImageToData(img: combineImg)
                        
                        let imgSaver = ImageSaver()
                        imgSaver.writeToPhotoAlbum(image: combineImg)
                        
                        do{
                            try managedObjectContext.save()
                        } catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        let combineImg = ImageCombiner().combinePhotos(topImg, midImg, botImg)
                        
                        editObject!.botPosition = Int32(botCounter)
                        editObject!.midPosition =  Int32(midCounter)
                        editObject!.topPosition = Int32(topCounter)
                        
                        editObject!.image = ImageConverter().convertImageToData(img: combineImg)
                        
                        
                        do{
                            try managedObjectContext.save()
                        } catch let error as NSError {
                            print("Could not edit. \(error.userInfo)")
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }){
                    ZStack{
                        Rectangle()
                            .fill(Color(#colorLiteral(red: 0, green: 0.4992540479, blue: 0.5453501344, alpha: 1)))
                        
                        Text("Save")
                            .font(.custom("Roboto-Medium", size: 14))
                            .foregroundColor(.white)
                    }
                }
                .cornerRadius(4)
                .frame(width: 102, height: 36)
                .shadow(color: .gray, radius: 4, x: 0, y: 5 )
                .padding(.top, 44)
            }
            
        }
        .sheet(isPresented: $presentShareSheet, content: {
            ShareSheet(items: items)
        })
    }
    
    
    func share() {
        let sharePhoto = ImageCombiner().combinePhotos(topImg, midImg, botImg)
        
        items.append(sharePhoto)
        
        presentShareSheet.toggle()
    }
}

class GetImage: ObservableObject {
    @Published var topImg: UIImage = UIImage(named: "IconAdd")!
}
