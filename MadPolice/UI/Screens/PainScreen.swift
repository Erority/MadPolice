//
//  PainScreen.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct PaintScreen: View, sharePhotoToHeader{
    @State private var presentShareSheet: Bool = false
    @State var items: [Any] = []
    
    @State private var isTakePic: Bool = false
    @State private var img: UIImage = UIImage(named: "IconAdd")!
    
    var body: some View {
        VStack {
            
            HeaderNav(titleStr: "Paint", sharePhoto: self, optionBUtton: 2)
            
            Spacer()
            PainComponent(paint: $img, takePaint: $isTakePic)
        }.sheet(isPresented: $presentShareSheet, content: {
            ShareSheet(items: items)
        })
    }
    
    func share() {
        isTakePic = true
        
        let sharePhoto = img
        
        items.removeAll()
        items.append(sharePhoto)
        
        presentShareSheet.toggle()
    }

}


extension View {
    func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.screenShot
  }
}

extension UIView {
   var screenShot: UIImage {
       let rect = self.bounds
       UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
       let context: CGContext = UIGraphicsGetCurrentContext()!
       self.layer.render(in: context)
       let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
       UIGraphicsEndImageContext()
       return capturedImage
   }
}
