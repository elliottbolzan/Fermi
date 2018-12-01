//
//  Server.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/15/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation
import Alamofire

class Server {
    
    public class func getUsersWith(filter: Filter) -> [Person] {
        let uri = Constants.host + "user/filter"
        var users = [Person]()
        Alamofire.request(uri, method: .get, parameters: filter.toJSON(), headers: nil).validate().responseJSON { response in
            guard response.result.isSuccess,
                let response = response.result.value as? [[String: Any]] else {
                    return
            }
            for entry in response {
                guard let person = Person(json: entry) else {
                    return
                }
                users.append(person)
            }
        }
        return users
    }
    
}
