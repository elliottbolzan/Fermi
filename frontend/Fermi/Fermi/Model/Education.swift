//
//  Education.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/2/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

struct Education: Codable {
    let id: Int
    var university: String
    var degreeType: String
    var startdate: String
    var enddate: String?
}
