//
//  TextFieldControl.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct TextFieldControl: View {
    @Binding var bindText: String
    var titleTextField: String
    var img: Image
    
    var body: some View {
        HStack(spacing: 8){
            
            img
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 36, height: 36)
            
            VStack{
                
                TextField(titleTextField, text: $bindText)
                    .padding(.bottom, 8)
                    .onChange(of: bindText) { newValue in
                        bindText = newValue
                    }
                
                Divider()
                    .background(.black)
                
            }
            .frame(height: 48)
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 37)
        .padding(.trailing, 25)
        .padding(.top, 18)
    }
}

