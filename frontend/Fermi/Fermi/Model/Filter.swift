//
//  Filter.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/18/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

class Filter: Codable {
    
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
