//
//  HeaderNavSecondVersion.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI

struct HeaderNavSecondVersion: View {
    
    var title: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ViewBuilder private var rightIcon 
    
    
    var body: some View {
        HStack{
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image("Back Arrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)
            }
            
            Spacer()
            
            Button(action: {}){
                
            }
        }
        .frame(maxWidth: .infinity)
        
        
        Text(title)
            .font(.custom("Calibri Regualr", size: 22))
            .foregroundColor(.white)
    }
}
