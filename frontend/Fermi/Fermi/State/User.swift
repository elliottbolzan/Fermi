//
//  User.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/14/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation
import FacebookCore

class User {
    
    static let shared = User()
    var person: Person? = nil;

    private init() {}
    
    var loggedIn: Bool = {
        if let accessToken = AccessToken.current {
            return true
        }
        return false
    }()
    
    func load(completion: @escaping (Person?) -> Void) {
        let connection = GraphRequestConnection()
        let parameters = ["fields": "id, name"]
        connection.add(GraphRequest(graphPath: "/me", parameters: parameters)) { httpResponse, result in
            switch result {
            case .success(let response):
                guard
                    let dict = response.dictionaryValue,
                    let id = dict["id"] as? String,
                    let name = dict["name"] as? String
                    else {
                        completion(nil)
                        return
                }
                Server.createUser(id: Int(id)!, name: name, token: AccessToken.current!.authenticationToken, completion: { person in
                    self.person = person
                    completion(person)
                })
            case .failed(_):
                completion(nil)
            }
        }
        connection.start()
    }
    
}
