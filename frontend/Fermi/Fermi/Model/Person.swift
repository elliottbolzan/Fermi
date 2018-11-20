//
//  Person.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct Person {
    
    let id: Int
    let name: String
    
    init?(json: [String: Any]) {
        print(json)
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String
            else {
                return nil
        }
        self.id = id
        self.name = name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    var profilePictureURL: String {
        return "http://graph.facebook.com/\(id)/picture?type=large"
    }
    
    func profilePicture(completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(profilePictureURL, method: .get).responseImage { response in
            guard let image = response.result.value else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
    
}
