//
//  CreateController.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/18/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func createWith<T>(identifier: String, type: T.Type) -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
