//
//  ButtonControl.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI
import Foundation

struct ButtonControl: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            ZStack{
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0, green: 0.4992540479, blue: 0.5453501344, alpha: 1)))
                
                Text(title)
                    .font(.custom("Roboto-Medium", size: 14))
                    .foregroundColor(.white)
            }
        }
        
    }
    
}
