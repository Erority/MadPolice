//
//  CheckBoxControl.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct CheckBoxControl: View {
    @Binding var isEnable: Bool
    
    var body: some View {
        Image(systemName: isEnable ? "checkmark.square.fill" : "square")
            .foregroundColor(isEnable ? Color(#colorLiteral(red: 0, green: 0.6931943893, blue: 0.7384516597, alpha: 1)) : Color.secondary)
            .onTapGesture {
                self.isEnable.toggle()
            }
    }
}

