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
    
    let id: Int
    let fbId: String
    let name: String
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let fbId = json["fb_id"] as? String,
            let name = json["name"] as? String
            else {
                return nil
        }
        self.id = id
        self.fbId = fbId
        self.name = name
    }
    
    init(fbId: String, name: String) {
        print(fbId)
        self.id = 0
        self.fbId = fbId
        self.name = name
    }
    
    var profilePictureURL: String {
        return "http://graph.facebook.com/\(fbId)/picture?type=large"
    }
    
}
