//
//  WantedScreen.swift
//  MADPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct WantedScreen: View, actionHeaderView {
    
    @StateObject var viewModel: WantedScreenViewModel = WantedScreenViewModel()
    @State var wantedItems: [WantedSubModel] = []
    @State var selectedWanted: WantedSubModel? = nil
    @State var selection: String? = nil
    
    var body: some View {
        VStack {
            
            NavigationLink(destination: ShowWantedScreen(bindModel: $selectedWanted).navigationBarHidden(true), tag: "ShowWantedScreen", selection: $selection) { EmptyView() }

            NavigationLink(destination: AddOrEditNewWantedScreen().navigationBarHidden(true), tag: "AddOrEditNewWantedScreen", selection: $selection) { EmptyView() }
            
            HeaderNav(titleStr: "Wanted", actionProtocol: self, optionButton: 3)
        
            switch viewModel.currentView {
                case WantedScreenViewModel.LIST_OF_WANTED:
                VStack{
                    NavigationView {
                        List {
                            ForEach(wantedItems){ item in
                                Button(action: {
                                    selectedWanted = item
                                    selection = "ShowWantedScreen"
                                }){
                                    ItemWanted(model: item)
                                }
                            }
                        }.listStyle(PlainListStyle())
                    }
                }
            case WantedScreenViewModel.DELETE_ITEM :
                VStack{
                    NavigationView {
                        List {
                            ForEach(wantedItems){ item in
                                DeleteWantedItem(model: item)
                            }
                        }.listStyle(PlainListStyle())
                    }
                    
                    Spacer()
                    
                    HStack{
                        
                    }.background(Color(#colorLiteral(red: 0.9228156209, green: 0.9377459884, blue: 0.9460901618, alpha: 1)))
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                }
                
            default:
                EmptyView()
            }
            
        }
        .onAppear {
            Api().getWanted { modelToGet in
                self.wantedItems = modelToGet.data
            }
        }
    }
    
    func addPhoto() {
        
    }
    
    func sharePhoto(uiImage: UIImage) {
        
    }
    
    func deleteItem() {
        viewModel.currentView = WantedScreenViewModel.DELETE_ITEM
    }
    
    func addItem() {
        selection = "AddOrEditNewWantedScreen"
    }
}

struct WantedScreen_Previews: PreviewProvider {
    static var previews: some View {
        WantedScreen()
    }
}


struct DeleteWantedItem: View {
    var model: WantedSubModel
    @State var checkState: Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: checkState ? "checkmark.square.fill" : "square")
                .foregroundColor(checkState ? Color(#colorLiteral(red: 0, green: 0.6931943893, blue: 0.7384516597, alpha: 1)) : Color.secondary)
                .onTapGesture {
                    self.checkState.toggle()
                }
            Text(model.last_name + model.first_name)
                .font(.custom("Roboto-Regular", size: 16))
                .foregroundColor(.black)

            
        }
    }
}

struct ItemWanted: View {
    var model: WantedSubModel
    var img: Image
    
    init (model: WantedSubModel) {
        self.model = model
        
        let url = URL(string: model.photo)!
        let dataImg = try! Data(contentsOf: url)
        let uiImg = UIImage(data: dataImg)
        
        img = Image(uiImage: uiImg!)
    }
    
    var body: some View {
        HStack {
            img
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 33, height: 33)
                .clipShape(Circle())
            
            Text(model.last_name + model.first_name)
                .font(.custom("Roboto-Regular", size: 16))
                .foregroundColor(.black)
        }
    }
}
