//
//  AboutUsScreen.swift
//  MADPolice
//
//  Created by Денис Большачков on 18.02.2022.
//

import SwiftUI

struct AboutUsScreen: View {
    var body: some View {
        VStack(){
            HeaderNav(title: "About Us", optionBUtton: 0)
            
            HStack (){
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 76, height: 76, alignment: .center)
                
                Text("WSK Police")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6931943893, blue: 0.7384516597, alpha: 1)))
                    .font(.custom("Scada-Regular", size: 45))
                    .padding(.top, 23)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 7)
            }
            .padding(.top, 8)
            
            HStack{
                
                Spacer()
                
                Text("Version 2.0")
                    .font(.custom("Roboto-Regular", size: 16))
                    .foregroundColor(.gray)
                    .padding(.trailing, 31)
            }
            .frame(maxWidth: .infinity)
            
            Text("WSK Police - Оперативно-розыскная деятельность - мероприятия, выполняемые гласно и негласно уполномоченными на это государственными  органами с целью выявить, пресечь или раскрыть преступление, отыскать скрывающихся и пропавших без вести людей, установить имущество, подлежащее конфискации, добыть информацию о событиях и деяниях, опасных для государства.")
                .lineSpacing(5)
                .font(.custom("Roboto-Regular", size: 16))
                .frame(maxWidth: .infinity)
                .frame(height: 265)
                .multilineTextAlignment(.center)
            
            HStack{
                Image("WSR")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 135, height: 90)
                
                Text("""
 2019 "WSK Police"
 Разработано с любовью в
 WorldSkills Russia compition
 F6 Mobile Application Development
 """)
                    .lineSpacing(5)
                    .font(.custom("Roboto-Regular", size: 16))
                    .frame(maxWidth: .infinity)
                    .frame(height: 126)
                    .multilineTextAlignment(.center)
                
            }
            .padding(.leading, 6)
            .padding(.top, 23)
            
            Spacer()
        }
    }
}

struct AboutUsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsScreen()
    }
}
