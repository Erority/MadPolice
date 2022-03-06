//
//  WorkWithUserDefaults.swift
//  MADPolice
//
//  Created by Денис Большачков on 01.03.2022.
//

import Foundation


private func getUserDataFromUD() -> UserSubModel{
    var userData: UserSubModel?
    
    if let data = UserDefaults.standard.data(forKey: "UserData"){
        do{
            let decoder = JSONDecoder()
            
            userData = try decoder.decode(UserSubModel.self, from: data)
        } catch{
            print("Unable to decode")
        }
    }
    
    return userData!
}

func saveDataToUserDefaults(userToSave: UserSubModel){
    do{
        let user = userToSave
        let data = try JSONEncoder().encode(user)
        
        
        UserDefaults.standard.set(data ,forKey: "UserData")
    } catch {
        print("Unable to Encode")
    }
}
