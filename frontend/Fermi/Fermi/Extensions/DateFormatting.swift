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
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
    
}
