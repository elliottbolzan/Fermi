//
//  Constants.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

struct Constants {
    static let host = "http://35.237.239.197:5000/"
    //static let host = "http://35.196.36.216:5000/"
//    static let host = "http://35.237.34.117:5000/"
//    static let host = "http://35.196.36.216:5000/"
    //static let host = "http://10.197.82.236:5000/"
    
    static let tint = UIColor(red: 235.0 / 256, green: 151.0 / 256, blue: 62.0 / 256, alpha: 1.0)
    static let dark = UIColor(red: 50.0 / 256, green: 50.0 / 256, blue: 50.0 / 256, alpha: 1.0)
    static let border = UIColor(red: 200.0 / 256, green: 200.0 / 256, blue: 200.0 / 256, alpha: 1.0)
    static let colors = [
        UIColor(red:0.98, green:0.83, blue:0.56, alpha:1.0),
        UIColor(red:0.97, green:0.76, blue:0.57, alpha:1.0),
        UIColor(red:0.42, green:0.54, blue:0.80, alpha:1.0),
        UIColor(red:0.51, green:0.80, blue:0.87, alpha:1.0),
        UIColor(red:0.72, green:0.91, blue:0.58, alpha:1.0),
        UIColor(red:0.96, green:0.73, blue:0.23, alpha:1.0),
        UIColor(red:0.90, green:0.31, blue:0.22, alpha:1.0),
        UIColor(red:0.29, green:0.41, blue:0.74, alpha:1.0),
        UIColor(red:0.38, green:0.64, blue:0.74, alpha:1.0),
        UIColor(red:0.47, green:0.88, blue:0.56, alpha:1.0),
        UIColor(red:0.98, green:0.60, blue:0.23, alpha:1.0),
        UIColor(red:0.24, green:0.39, blue:0.51, alpha:1.0)
    ].shuffled()
    
    static let facts = [
        "generosity": "Refers %@ people than %d%% of users.",
        "impact": "Creates %@ offers than %d%% of users.",
        "popularity": "Is referred %@ often than %d%% of users.",
        "success": "Gets offers %@ often than %d%% of users."
    ]
    
    static let factAdjectives = [
        "generosity": "Generous",
        "impact": "Impactful",
        "popularity": "Popular",
        "success": "Successful"
    ]
    
}
