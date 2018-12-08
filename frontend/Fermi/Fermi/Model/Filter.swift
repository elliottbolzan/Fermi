//
//  Filter.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/18/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

class Filter: Codable, Equatable {
    
    
    var name: String
    var company: String
    var university: String
    var qualities: [Quality]
    var limit: Int = 20
    var offset: Int = 0
    
    init(name: String, company: String, university: String, qualities: [Quality]) {
        self.name = name
        self.company = company
        self.university = university
        self.qualities = qualities
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        var qualitiesEqual = true
        if lhs.qualities.count != rhs.qualities.count {
            qualitiesEqual = false
        }
        else {
            for i in 0..<lhs.qualities.count {
                if lhs.qualities[i].percentile != rhs.qualities[i].percentile ||
                    lhs.qualities[i].name != rhs.qualities[i].name {
                    qualitiesEqual = false
                }
            }
        }
        return lhs.name == rhs.name && lhs.company == rhs.company && lhs.university == rhs.university && qualitiesEqual
    }
    
    func active() -> Bool {
        return name != "" || company != "" || university != "" || qualities.count > 0
    }
    
    func clear() {
        name = ""
        company = ""
        university = ""
        qualities = []
        offset = 0
    }
    
}
