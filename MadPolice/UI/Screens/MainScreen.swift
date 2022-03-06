//
//  MainScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct MainScreen: View, toAnotherView {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    let menuItemsFirstV: [MenuItem] = [
        MenuItem(name: "Departments", image: Image("ShieldUser"), tagView: "DepartmentScreen"),
        MenuItem(name: "Wanted", image: Image("DetectedUserFace"), tagView: "WantedScreen"),
        MenuItem(name: "Paint", image: Image("UserFace"), tagView: "PaintScreen"),
        MenuItem(name: "PhotoRobot", image: Image("AddNoteImage"), tagView: "PhotoRobotScreen"),]
    
    let menuItemsSecondV: [MenuItem] = [
        MenuItem(name: "Criminal Cases", image: Image("IconAlert"), tagView: "CriminalCasesScreen"),
        MenuItem(name: "Departments", image: Image("ShieldUser"), tagView: "DepartmentScreen"),
        MenuItem(name: "Wanted", image: Image("DetectedUserFace"), tagView: "WantedScreen"),
        MenuItem(name: "Paint", image: Image("UserFace"), tagView: "PaintScreen"),
        MenuItem(name: "PhotoRobot", image: Image("AddNoteImage"), tagView: "PhotoRobotScreen"),]
    
    @State private var selection: String? = nil
    
    var option: Int
    
    var body: some View {
    
        VStack {
            NavigationLink(destination: CriminalCaseesScreen().navigationBarHidden(true), tag: "CriminalCasesScreen", selection: $selection) { EmptyView() }
            
            NavigationLink(destination: DepartmentScreen().navigationBarHidden(true), tag: "DepartmentScreen", selection: $selection) { EmptyView() }
            
            NavigationLink(destination: WantedScreen().navigationBarHidden(true), tag: "WantedScreen", selection: $selection) { EmptyView() }
            
            NavigationLink(destination: PaintScreen().navigationBarHidden(true), tag: "PaintScreen", selection: $selection) { EmptyView() }
            
            NavigationLink(destination: PhotoRobotScreen().navigationBarHidden(true), tag: "PhotoRobotScreen", selection: $selection) { EmptyView() }
            
            NavigationLink(destination: AboutUsScreen().navigationBarHidden(true), tag: "AboutUsView", selection: $selection) { EmptyView() }
            
            
            HeaderNav(title: "Main", optionBUtton: 0)
            
            NavigationView {
                
                ScrollView {
                    
                    if option == 1{
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                            ForEach(menuItemsFirstV){ item in
                                
                                ItemRow(item: item, toAnotherView: self)
                            }
                            
                        }
                    } else {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                            ForEach(menuItemsSecondV){ item in
                                
                                ItemRow(item: item, toAnotherView: self)
                            }
                            
                        }
                        
                        ItemRow(item: MenuItem(name: "About Us", image: Image("ShieldQuestionIcon"), tagView: "AboutUsView"), toAnotherView: self)
                            .padding(.top, 167)
                        
                        Button (action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            HStack {
                                Image("IconLogout")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 36, height: 36)
                                    .padding(.leading, 6)
                                
                                Text("Logout")
                                    .padding(.leading, 18)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .border(.gray)
                            
                        }
                    }
                }
                
            }
            Spacer()

        }
    }
    
    func changeView(tagView: String) {
        selection = tagView
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(option: 1)
    }
}

protocol toAnotherView {
    func changeView(tagView: String)
}

struct ItemRow: View {
    let item: MenuItem
    
    let toAnotherView: toAnotherView
    
    
    var body: some View {
        Button (action: {
            toAnotherView.changeView(tagView: item.tagView)
        }){
            HStack {
                item.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
                    .padding(.leading, 6)
                
                Text(item.name)
                    .padding(.leading, 18)
                    .font(.custom("Roboto-Regular", size: 16))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .border(.gray)
    }
}
    
    struct MenuItem: Identifiable{
        var id = UUID()
        var name: String
        var image: Image
        var tagView: String
    }
