//
//  ShowDepartmentScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI
import MapKit

struct ShowDepartmentScreen: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var department: DepartmentSubModel?
    
    @StateObject var viewModel: ShowDepartmentViewModel = ShowDepartmentViewModel()
    
    @State private var selection: String? = nil
    @State private var isShowDescription = false
    
    
    var body: some View {
        
        VStack{
            HeaderNav(title: "ShowDepartment", optionBUtton: 0)
            
            if viewModel.currentViewIsINFO {
                VStack {

                    OnePropInfo(title: "Department name:", content: department!.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    

                    OnePropInfo(title: "Address:", content: department!.address)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    

                    OnePropInfo(title: "Boss:", content: department!.boss)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 10)

                    HStack (spacing: 55){
                        OnePropInfo(title: "Phone:", content: department!.phone)
                        OnePropInfo(title: "Email:", content: department!.email)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 10)

                    VStack {
                        HStack (){
                            Text("Description")
                                .font(.custom("Roboto-Regular", size: 14))
                                .foregroundColor(.black)

                            Spacer()
                            
                            Button(action: {
                                isShowDescription.toggle()
                            }){
                                ZStack {
                                    Rectangle()
                                        .strokeBorder(Color(#colorLiteral(red: 0.5816243887, green: 0.5965673327, blue: 0.604908824, alpha: 1)))
                                        
                                    Image(systemName: !isShowDescription ? "chevron.down" : "chevron.up")
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 16)
                        }
                        
                        if(isShowDescription){
                            Text(department!.description)
                                .frame(maxWidth: .infinity)
                                .padding(.trailing, 29)
                                .padding(.leading, 25)
                                .padding(.top, 5)
                                .font(.custom("Roboto-Regular", size: 14))
                                .foregroundColor(.black)
                                .frame(maxHeight: 140)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 23)

                    Button(action: {
                        viewModel.currentViewIsINFO = false
                    }){
                        ZStack{
                            Rectangle()
                                .fill(Color(#colorLiteral(red: 0, green: 0.4992540479, blue: 0.5453501344, alpha: 1)))

                            Text("Show")
                                .font(.custom("Roboto-Medium", size: 14))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
                    .padding(.top, 43)
                    .padding(.horizontal, 95)
                    
                    
                    Spacer()
                }
            }else {
                EmptyView()
                
            }
        }
    }
    
    func getCoordsFromString(stringCoords: String) -> [Double] {
        var prepareString = stringCoords
        
        prepareString.removeFirst()
        prepareString.removeLast()
        
        var arrString = prepareString.components(separatedBy: ",")
        
        arrString[1].removeFirst()
        
        var toRet = [Double]()
        toRet.append(Double(arrString[0])!)
        toRet.append(Double(arrString[1])!)
        
        return toRet
                
        }
}

struct OnePropInfo: View{

    var title: String
    var content: String

    var body: some View{
        VStack(alignment: .leading){
            Text(title)
                .font(.custom("Roboto-Regular", size: 16))
                .foregroundColor(.black)

            Text(content)
                .font(.custom("Roboto-Regular", size: 16))
                .foregroundColor(.black)
                .padding(.top, 10)
        }
    }
}

//struct MapInfoOfDepartment: View{
//    @StateObject var viewModel: ShowDepartmentViewModel
//
//    @State private var annotationItem = [AnnotatedItem]()
//    @State var department: DepartmentSubModel
//
//    var body: some View {
//        ZStack{
//
//            Button(action: {}){
//                ZStack{
//                    Circle()
//                        .fill(.white)
//
//                    Image("Location Icon")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 24, height: 24)
//                }
//            }
//            .frame(width: 56, height: 56)
//            .frame(maxHeight: .infinity, alignment: .bottom)
//            .frame(maxWidth: .infinity, alignment: .trailing)
//            .padding(.trailing, 12)
//            .padding(.bottom, 66.1)
//        }
//        .onAppear {
//            viewModel.setNameDepartmen(depName: department.name)
//            viewModel.calculateCoordsOfDepartment(depCoords: department.coords)
//            annotationItem.append(AnnotatedItem(name: viewModel.nameOfDepartment!, coordinate: viewModel.coordsOfDepartment!))
//        }
//    }
//}
//
//struct AnnotatedItem: Identifiable {
//    let id = UUID()
//    var name: String
//    var coordinate: CLLocationCoordinate2D
//}
