//
//  DepartmentScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct DepartmentScreen: View {
    
    @State var departmentList = [DepartmentSubModel]()
    @State var selection: String? = nil
    @State var selectedDepartment: DepartmentSubModel? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            HeaderNav(title: "Departments", optionBUtton: 0)

            NavigationLink(destination: ShowDepartmentScreen(department: $selectedDepartment).navigationBarHidden(true), tag: "ShowDepartmentScreen", selection: $selection) { EmptyView() }
            NavigationView {
                
                List() {
                    ForEach(departmentList){ dep in
                        Button(action: {
                            selectedDepartment = dep
                            selection = "ShowDepartmentScreen"
                        }){
                            HStack{
                                
                                VStack (alignment: .leading){
                                    Text(dep.name)
                                        .font(.custom("Roboto-Regular", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text(dep.address)
                                        .font(.custom("Roboto-Regular", size: 14))
                                        .foregroundColor(.gray)
                                    
                                    
                                }
                                .padding(.leading, 15)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 72)
                        }
                    }
                    .padding(0)
                }
            .padding(0)
        }
        .listStyle(PlainListStyle())
        .onAppear {
            Api().getDepartments(completion: { dep in
                self.departmentList = dep.data
            })
        }
    }
    
    
}



struct DepModel: View{
    var dep: DepartmentSubModel
    
    var body: some View {
        Button(action: {
            
        }){
            HStack{
                VStack (alignment: .leading){
                    Text(dep.name)
                        .font(.custom("Roboto-Regular", size: 16))
                        .foregroundColor(.black)
                    
                    Text(dep.address)
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundColor(.gray)
                    
                    
                }
                .padding(.leading, 15)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 72)
        }
    }
}}

