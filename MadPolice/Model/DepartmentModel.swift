//
//  DepartmentModel.swift
//  MadPolice
//
//  Created by Денис Большачков on 03.03.2022.
//

import Foundation

struct DepartmentSubModel: Codable, Identifiable {
    var id: String
    var address: String
    var boss: String
    var name: String
    var phone: String
    var email: String
    var description: String
    var coords: String
}

struct DepartmentFullModel: Codable {
    var data: [DepartmentSubModel]
    var success: Bool
}
