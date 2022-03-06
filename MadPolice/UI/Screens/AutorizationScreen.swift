//
//  AutorizationScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct AutorizationScreen: View {
    
    @State var login: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = false
    
    @State var counterOfSign = 0
    @State var capchaText = ""
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView{
            
            VStack {
                NavigationLink(destination: MainScreen(option: 1).navigationBarHidden(true), tag: "MainScreenByGuest", selection: $selection) { EmptyView() }
                NavigationLink(destination: MainScreen(option: 0).navigationBarHidden(true), tag: "MainScreenByUser", selection: $selection) { EmptyView() }
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 96, height: 96)
                    .padding(.top, 39)
                
                Text("WSK Police")
                    .font(.custom("Scada-Regular", size: 45))
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6931943893, blue: 0.7384516597, alpha: 1)))
                    .padding(.top, 23)
                
                TextFieldControl(bindText: $login, titleTextField: "Login", img: Image("LoginFieldImage"))
                    .padding(.top, 18)
                
                TextFieldControl(bindText: $password, titleTextField: "Password", img: Image("PasswordFieldImage"))
                
                
                HStack (){
                    CheckBoxControl(isEnable: $rememberMe)
                    
                    Text("Remember me")
                        .font(.custom("Roboto-Regular", size: 14))
                }
                
                if counterOfSign < 3{
                    ButtonControl(title: "SignIn", action: signIn)
                        .cornerRadius(4)
                        .frame(width: 170, height: 36)
                        .shadow(color: .gray, radius: 4, x: 0, y: 5)
                        .padding(.top, 52)
                    ButtonControl(title: "Guess", action: guess)
                        .cornerRadius(4)
                        .frame(width: 170, height: 36)
                        .shadow(color: .gray, radius: 4, x: 0, y: 5 )
                        .padding(.top, 15)
                } else {
                    CapchaControls(bindText: $capchaText)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
        }
    }
    
    func signIn(){
        Api().getUser(login: self.login, password: self.password) { model in
            if model.success {
                
                saveDataToUserDefaults(userToSave: model.data)
                selection = "MainScreenByUser"
                
            } else {
                counterOfSign += 1
            }
        }
    }
    
    func guess(){
        selection = "MainScreenByGuest"
    }
    
}

struct AutorizationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AutorizationScreen()
    }
}
