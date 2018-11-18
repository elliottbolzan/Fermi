//
//  State.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/16/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class State {
    
    static let shared = State()
    var colors = [Int: UIColor]()
    
    private init() {}

    func colorFor(id: Int) -> UIColor {
        var color = colors[id]
        if color == nil {
            color = Constants.colors[id % Constants.colors.count]
            colors[id] = color
        }
        return color!
    }
    
}

