//
//  Hairline.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideHairline() {
        for view in (self.navigationController!.navigationBar.subviews) {
            for subview in view.subviews {
                if let imageView = subview as? UIImageView {
                    imageView.isHidden = true
                }
            }
        }
    }
    
    func showHairline() {
        for view in (self.navigationController!.navigationBar.subviews) {
            for subview in view.subviews {
                if let imageView = subview as? UIImageView {
                    imageView.isHidden = false
                }
            }
        }
    }
    
}
