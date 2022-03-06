//
//  WantedModel.swift
//  MADPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import Foundation

struct WantedSubModel: Codable, Identifiable {
    var id: String
    var status: String
    var first_name: String
    var last_name: String
    var last_location: String
    var nicknames: String
    var description: String
    var photo: String
}

struct WantedFullModel: Codable {
    var data: [WantedSubModel]
    var success: Bool
}
