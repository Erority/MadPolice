//
//  WantedScreenViewModel.swift
//  MADPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import Foundation

class WantedScreenViewModel: ObservableObject {
    static var LIST_OF_WANTED: Int = 0
    static var ADD_ITEM: Int = 1
    static var DELETE_ITEM: Int = 2
    
    
    @Published var currentView: Int = 0
    
    
}
