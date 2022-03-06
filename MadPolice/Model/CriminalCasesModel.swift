//
//  CriminalCasesModel.swift
//  MadPolice
//
//  Created by Денис Большачков on 05.03.2022.
//

import Foundation

struct CriminalFullModel: Codable {
    var data: [CriminalSubModel]
    var success: Bool
}

struct CriminalSubModel: Codable {
    var id: String
    var category: String
    var detective: String
    var client: String
    var number: String
    var description: String
    var create_date: String
    var images: [CriminalImagesModel]
}

struct CriminalImagesModel: Codable {
    var id: String
    var title: String
    var link: String
}
