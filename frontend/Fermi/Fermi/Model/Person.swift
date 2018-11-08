//
//  Person.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

struct Person {
    
    let id: Int
    let name: String
    let email: String
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let email = json["email"] as? String
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.email = email
    }
    
}
