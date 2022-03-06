//
//  AudioScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 06.03.2022.
//

import SwiftUI

struct AudioScreen: View {
    var body: some View {
        VStack{
            HeaderNav(title: "Audio", optionBUtton: 3)
            
            
            Spacer()
        }
    }
}

struct AudioScreen_Previews: PreviewProvider {
    static var previews: some View {
        AudioScreen()
    }
}

private struct AudioItem: View {
    var body: some View {
        HStack {
            
        }
    }
}
