//
//  CapchaControls.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI


struct CapchaControls: View {
    
    
    var rndDegrees = Int.random(in: (0...360))
    private var text: String = "1234567890qwertyuiopasdfghjklzxcvbnm"
    
    var capcha: String = ""
    @State var capchaReady: Bool = true
    
    @Binding var textBind: String
    
    
    init(bindText: Binding<String>){
        _textBind = bindText
        self.capcha = getRandomSymb(text)
    }
    
    var body: some View {
        VStack {
            Text("Enter capcha:")
            
            ZStack {
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.7758991122, green: 0.3824980259, blue: 0.8018960953, alpha: 1)))
                    .frame(width: 89.33, height: 89.33)
                    .cornerRadius(15)
                
                HStack (spacing: 4){
                    if capchaReady {
                        Text(capcha[0])
                            .rotationEffect(.degrees(Double(rndDegrees)))
                            .foregroundColor(Color(#colorLiteral(red: 0.5285416842, green: 0.3448909521, blue: 0.7032105327, alpha: 1)))
                        Text(capcha[1])
                            .rotationEffect(.degrees(Double(rndDegrees))).foregroundColor(Color(#colorLiteral(red: 0.5285416842, green: 0.3448909521, blue: 0.7032105327, alpha: 1)))
                        Text(capcha[2])
                            .rotationEffect(.degrees(Double(rndDegrees))).foregroundColor(Color(#colorLiteral(red: 0.5285416842, green: 0.3448909521, blue: 0.7032105327, alpha: 1)))
                    }
                }
            }.padding(0)
            
            VStack{
                TextField("ic8", text: $textBind)
                Divider().background(.black)
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 95)
        }
    }
    
    
    func getRandomSymb(_ input: String) -> String {
        var _: Int = Int.random(in: (0...input.count - 1))
        var strToRet = ""
        
        
        for _ in 0..<3 {
            strToRet.append(text.randomElement()!)
        }
        
        return strToRet
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

