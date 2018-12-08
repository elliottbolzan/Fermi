//
//  Experience.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/2/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

struct Experience: Codable {
    let id: Int
    let company: String
    let position: String
    let startdate: String
    let enddate: String?
}
