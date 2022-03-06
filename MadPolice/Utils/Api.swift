//
//  Api.swift
//  MADPolice
//
//  Created by Денис Большачков on 01.03.2022.
//

import Foundation


class Api{
    public static var API_ADDRESS: String = "http://mad2019.hakta.pro/api"
    
    func getDepartments(completion: @escaping  (DepartmentFullModel) -> ()) {
        var request = URLRequest(url: URL(string: Api.API_ADDRESS + "/department")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let jsonResponse = try! JSONDecoder().decode(DepartmentFullModel.self, from: data!)
            completion(jsonResponse)
        }.resume()
    }
    
    func getWanted(completion: @escaping (WantedFullModel) -> ()){
        var request = URLRequest(url: URL(string: Api.API_ADDRESS + "/wanted")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let jsonResponse = try! JSONDecoder().decode(WantedFullModel.self, from: data!)
            completion(jsonResponse)
        }.resume()
    }
    
    
    func getUser(login: String, password: String, completion: @escaping (UserFullModel) -> ()) {
        let semaphore = DispatchSemaphore(value: 0)

        var request = URLRequest(url: URL(string: "http://mad2019.hakta.pro/api/login/?login=\(login)&password=\(password)")!)
        request.httpMethod = "GET"


            URLSession.shared.dataTask(with: request){ data, response, error in
                if let error = error {
                    print("Request Error: \(error.localizedDescription)")
                    completion(UserFullModel(data: UserSubModel(id: "", login: "", name: "", token: ""), success: false))
                    semaphore.signal()
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode)
                else {
                    completion(UserFullModel(data: UserSubModel(id: "", login: "", name: "", token: ""), success: false))
                    semaphore.signal()
                    return 
                }


                let jsonResponse = try! JSONDecoder().decode(UserFullModel.self, from: data!)
                completion(jsonResponse)

                semaphore.signal()
            }.resume()

        semaphore.wait()

    }
    
    func getCriminalCases(completion: @escaping (CriminalFullModel) -> ()) {
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: Api.API_ADDRESS + "/criminal_case/")!,timeoutInterval: Double.infinity)
        request.addValue("a2f6ecb0-88e1-b4f2-09ea-ec1cfd678d54", forHTTPHeaderField: "user_id")
        request.addValue("caeeb758-782e-9188-ff5a-79d425319c43", forHTTPHeaderField: "token")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            print(String(data: data, encoding: .utf8)!)
            
            let jsonResponse = try! JSONDecoder().decode(CriminalFullModel.self, from: data)
            completion(jsonResponse)
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
    func postCriminalCase(model: CriminalSubModel){

        var semaphore = DispatchSemaphore (value: 0)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        let timeStrToSend = formatter.string(from: Date.now)

        let parameters = "{\n        \"id\": \"\",\n        \"category\": \"\(model.category)\",\n        \"detective\": \"\(model.detective)\",\n        \"client\": \"\(model.client)\",\n        \"number\": \"\(model.number)\",\n        \"description\": \"\(model.description)\",\n        \"create_date\": \"\(timeStrToSend)\",\n\n        }"
        let postData = parameters.data(using: .utf8)
        print(parameters)

        var request = URLRequest(url: URL(string: Api.API_ADDRESS + "/criminal_case")!,timeoutInterval: Double.infinity)
        request.addValue("a2f6ecb0-88e1-b4f2-09ea-ec1cfd678d54", forHTTPHeaderField: "user_id")
        request.addValue("caeeb758-782e-9188-ff5a-79d425319c43", forHTTPHeaderField: "token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
}
