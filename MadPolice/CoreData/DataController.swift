//
//  DataController.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MadPoliceDB")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
            }
        }
    }
}
