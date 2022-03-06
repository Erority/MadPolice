//
//  ShareSheet.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    
    var items: [Any]
    
    func makeUIViewController(context: Context) -> some UIActivityViewController {
        
        let controller =  UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
