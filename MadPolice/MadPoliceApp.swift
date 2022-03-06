//
//  MadPoliceApp.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import SwiftUI

@main
struct MadPoliceApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            AutorizationScreen().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
