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

struct Person: Codable {
    
    let id: Int
    let name: String
    var education: [Education]
    var experience: [Experience]
    let qualities: [Quality]
    let lastActive: String?
    

    
    func equals(Person2: Person) -> Bool {
        if self.id == Person2.id {
            return true
        }
        return false
    }
    
    func fact() -> String {
        let interesting = mostInterestingQuality()
        let result = Constants.facts[interesting.name]
        var comparison = "more"
        var value = interesting.percentile
        if value < 50 {
            comparison = "less"
            value = 100 - value
        }
        return String(format: result ?? "", comparison, value)
    }
    
    func mostInterestingQuality() -> Quality {
        var interesting = qualities.first!
        for quality in qualities {
            if (abs(quality.percentile - 50) > abs(interesting.percentile - 50)) {
                interesting = quality
            }
        }
        return interesting
    }
    
}
