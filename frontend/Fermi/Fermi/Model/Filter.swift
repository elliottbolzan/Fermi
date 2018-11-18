//
//  Filter.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/18/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

struct Filter {
    let name: String
    let company: String
    let university: String
    let qualities: [Quality]
}

struct Quality {
    let name: String
    let order: Order
    let percentile: Int
}

enum Order: String {
    case Top, Bottom
}
