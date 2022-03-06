//
//  CustomTextFieldControl.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI

struct CustomTextFieldControl: View {
    
    var title: String
    @Binding var content: String
    
    var body: some View {
        VStack (alignment: .leading){
            Text(title)
                .font(.custom("Roboto-Regular", size: 16))
            
            TextField(title, text: $content)
                .font(.custom("Roboto-Regular", size: 16))
                .padding(.top, 3)
            
            Divider()
                .frame(height: 2)
                .background(Color(#colorLiteral(red: 0, green: 0.4992540479, blue: 0.5453501344, alpha: 1)))
                .padding(.top, 4)
        }
    }
}
