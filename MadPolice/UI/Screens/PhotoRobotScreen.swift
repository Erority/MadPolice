//
//  PhotoRobotScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI
import CoreData

struct PhotoRobotScreen: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: PhotoRobot.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \PhotoRobot.topPosition, ascending: true),
        NSSortDescriptor(keyPath: \PhotoRobot.midPosition, ascending: true),
        NSSortDescriptor(keyPath: \PhotoRobot.botPosition, ascending: true),
        NSSortDescriptor(keyPath: \PhotoRobot.image, ascending: true)
    ])
    private var data: FetchedResults<PhotoRobot>
    
    @State private var selection: String? = nil
    @State private var selected: PhotoRobot?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
   
    var body: some View {
        VStack{
            
            NavigationLink(destination: NewPhotoRobotScreen(editObject: $selected).navigationBarHidden(true), tag: "NewPhotoRobotScreenWithParam", selection: $selection) { EmptyView() }
            
            HeaderNav(title: "PhotoRobot", optionBUtton: 1)
            
            ScrollView{
                LazyVGrid (columns: columns) {
                    ForEach(data, id: \.id) { item in
                        
                        
                        Button(action: {
                            selected = item
                            selection = "NewPhotoRobotScreenWithParam"
                        }){
                        
                            Image(uiImage: UIImage(data: item.image!)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 68, height: 68)
                        }
                        .simultaneousGesture(
                            LongPressGesture().onEnded({ _ in
                                deleteItem(item: item)
                            }))
                        
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func deleteItem(item: NSManagedObject){
        withAnimation {
            managedObjectContext.delete(item)
            
            do {
                try managedObjectContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func editItem(item: NSManagedObject){
        
    }
}

struct PhotoRobotScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRobotScreen()
    }
}
