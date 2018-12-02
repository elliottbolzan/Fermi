//
//  Filter.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/18/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

struct Filter: Codable {
    let name: String
    let company: String
    let university: String
    let qualities: [Quality]
}
