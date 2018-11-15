//
//  Person.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation
import FacebookCore

struct Person {
    
    let id: String
    let name: String
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
            let name = json["name"] as? String
            else {
                return nil
        }
        self.id = id
        self.name = name
    }
    
    init(id: String, name: String) {
        print(id)
        self.id = id
        self.name = name
    }
    
    var profilePictureURL: String {
        return "http://graph.facebook.com/\(id)/picture?type=large"
    }
    
}
