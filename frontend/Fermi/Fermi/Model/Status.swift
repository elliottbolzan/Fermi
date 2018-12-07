//
//  Status.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

enum Status: String, Codable {
    case requested, granted, offered, denied, rejected
}
