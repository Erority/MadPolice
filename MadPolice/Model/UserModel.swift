//
//  UserModel.swift
//  MADPolice
//
//  Created by Денис Большачков on 01.03.2022.
//

import Foundation

struct UserSubModel: Codable {
    var id: String
    var login: String
    var name: String
    var token: String
}

struct UserFullModel: Codable{
    var data: UserSubModel
    var success: Bool
}

