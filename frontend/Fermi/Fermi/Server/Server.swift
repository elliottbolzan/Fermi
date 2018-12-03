//
//  Server.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/15/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation
import Alamofire
import FacebookCore

class Server {
    
    class func headers() -> [String: String] {
        return [
            "Authorization": AccessToken.current?.authenticationToken ?? "",
            "id": String(User.shared.person?.id ?? -1)
        ]
    }
    
    public class func createUser(id: Int, name: String, token: String, completion: @escaping (Person) -> Void) {
        let uri = Constants.host + "user/create"
        let parameters: [String: Any] = [
            "id": id,
            "name": name,
            "token": token
        ]
        Alamofire.request(uri, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            guard response.result.isSuccess,
                let response = response.result.value as? [String: Any] else {
                    return
            }
            let data = try! JSONSerialization.data(withJSONObject: response, options: [])
            let decoded = String(data: data, encoding: .utf8)!
            completion(Person.from(json: decoded))
        }
    }
    
    public class func getUsersWith(filter: Filter, completion: @escaping ([Person]) -> Void) {
        let uri = Constants.host + "user/filter"
        var users = [Person]()
        Alamofire.request(uri, method: HTTPMethod.post, parameters: filter.toJSON(), encoding: JSONEncoding.default, headers: headers()).validate().responseJSON { response in
            guard response.result.isSuccess,
                let response = response.result.value as? [[String: Any]] else {
                    return
            }
            for entry in response {
                let data = try! JSONSerialization.data(withJSONObject: entry, options: [])
                let decoded = String(data: data, encoding: .utf8)!
                let person = Person.from(json: decoded)
                users.append(person)
            }
            completion(users)
        }
    }
    
}
