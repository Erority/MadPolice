//
//  CriminalCaseesScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 04.03.2022.
//

import SwiftUI

struct CriminalCaseesScreen: View {
    
    @State private var isShowCategory = false
    @State private var isShowParameter = false
    @State private var isShowOrder = false
    private var categoryItems = [ItemsModel(title: "Detectives"), ItemsModel(title: "Date")]
    private var parameterItems = [ItemsModel(title: "All"), ItemsModel(title: "Specific element")]
    
    private var orderItems = [ItemsModel(title: "Desceding order"), ItemsModel(title: "Asceding order")]
    
    //Result
    @State var criminalItems = [CriminalSubModel]()
    @State var resultCount: String = "10"
    
    //Filter data
    @State private var selectedCategory: ItemsModel = ItemsModel(title: "")
    @State private var selectedParameter: ItemsModel = ItemsModel(title: "")
    @State private var selectedOrder: ItemsModel = ItemsModel(title: "")
    
    var body: some View {
        VStack{
            HeaderNav(title: "CriminalCases", optionBUtton: 0)
            
            ScrollView{
                VStack{
                    
                    DropDownList(titleOfItems: "Category", isShow: $isShowCategory, selectedItem: $selectedCategory, items: categoryItems)
                        .onChange(of: selectedCategory) { newValue in
                            selectedCategory = newValue
                            print(newValue.title)
                            filter()
                        }
                    
                    DropDownList(titleOfItems: "Parameter", isShow: $isShowParameter, selectedItem: $selectedParameter, items: parameterItems)
                        .onChange(of: selectedParameter) { newValue in
                            selectedParameter = newValue
                            filter()
                            resultCount = "Result(\(criminalItems.count)):"
                        }
                    
                    DropDownList(titleOfItems: "Order", isShow: $isShowOrder, selectedItem: $selectedOrder, items: orderItems).onAppear {
                        Api().getCriminalCases { itm in
                            criminalItems = itm.data
                            resultCount = "Result(\(criminalItems.count)):"
                        }
                    }.onChange(of: selectedOrder) { newValue in
                        selectedOrder = newValue
                        filter()
                    }
                    
                    Result(items: $criminalItems, resultCount: $resultCount)
                    
                    Spacer()
                }
            }
        }
    }
    
    private func filter() {
        
        if selectedParameter.title == "All" || selectedParameter.title == "" {
            return
        } else if selectedCategory.title == "" {
            return
        } else if selectedOrder.title == "" {
            return
        }
        
        
        switch selectedCategory.title {
        case "Detectives":
            if selectedOrder.title == "Desceding order" {
                
                criminalItems.sort { $0.detective < $1.detective }
                
            } else {
                
                criminalItems.sort { $0.detective > $1.detective }
                criminalItems.reverse()
            }
            
        case "Date":
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
            
            if selectedOrder.title  == "Desceding order" {
                
                criminalItems.sort { itemA, itemB in
                    return dateFormatter.date(from: itemA.create_date)! < dateFormatter.date(from: itemB.create_date)!
                }
                
            } else {
                
                criminalItems.sort { itemA, itemB in
                    return dateFormatter.date(from: itemA.create_date)! > dateFormatter.date(from: itemB.create_date)!
                }
            }
        
        default:
            break
        }
    }
}

struct CriminalCaseesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CriminalCaseesScreen()
    }
}

struct ItemsModel: Identifiable, Equatable{
    var id = UUID()
    var title: String
}


struct Result: View {
    
    @Binding var items: [CriminalSubModel]
    @Binding var resultCount: String
    @State private var selection: String? = nil
    @State private var selectedItem = CriminalSubModel(id: "", category: "", detective: "", client: "", number: "", description: "", create_date: "", images: [CriminalImagesModel]())
    var body: some View{
        
        VStack{
            
            NavigationLink(destination: ShowCriminalCasesScreen(model: $selectedItem ).navigationBarHidden(true), tag: "ShowCriminalCasesScreen", selection: $selection) { EmptyView() }
            
            Text(resultCount)
                .font(.custom("Roboto-Regular", size: 14))
                .foregroundColor(.black)
                .padding(.leading, 23)
                .frame(height: 40)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(0)
                .border(.gray)
            
            
            
            ForEach(items, id: \.id){ item in
                Button(action: {
                    selectedItem = item
                    selection = "ShowCriminalCasesScreen"
                }){
                    HStack{
                        Text(item.number)
                            .font(.custom("Roboto-Regular", size: 14))
                            .foregroundColor(.black)
                            .padding(.leading, 23)
                        Spacer()
                    }
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
            }
            .padding(0)
            .border(.gray)
        }
    }
}


struct DropDownList: View {
    
    var titleOfItems: String
    @Binding var isShow: Bool
    @Binding var selectedItem: ItemsModel
    var items: [ItemsModel]
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isShow.toggle()
                }
            }){
                HStack{
                    Text(titleOfItems)
                        .font(.custom("Roboto-Regular", size: 14))
                        .padding(.leading, 24)
                        .foregroundColor(.black)
                        .frame(height: 30)
                    Spacer()
                    Image(systemName: !isShow ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                        .padding(.trailing, 27)
                }
                .background(Color(#colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)))
                .border(.gray)
            }
            
            if isShow{
                
                ForEach(items){ item in
                    Button(action: {
                        selectedItem = item
                    }){
                        HStack{
                            Text(item.title)
                                .font(.custom("Roboto-Regular", size: 14))
                                .foregroundColor(.black)
                                .padding(.leading, 23)
                            Spacer()
                        }
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                }
                .padding(0)
                .border(.gray)
            }
        }
    }
}
