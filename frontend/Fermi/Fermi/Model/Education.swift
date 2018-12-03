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
    let university: String
    let degreeType: String
    let startdate: String
    let enddate: String?
}
