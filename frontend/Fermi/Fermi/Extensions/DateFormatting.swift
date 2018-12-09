//
//  DateFormatting.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/9/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

extension Date {
    
    func toBackendFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return formatter.string(from: self)
    }
    
    static func fromBackendFormat(input: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return formatter.date(from: input)!
    }
    
    
}
