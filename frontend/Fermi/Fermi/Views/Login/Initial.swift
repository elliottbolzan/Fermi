//
//  Initial.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/14/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import FacebookCore

class Initial: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pickViewController()
    }
    
    func pickViewController() {
        if User.shared.loggedIn {
            User.shared.load(completion: { person in
                guard person != nil else {
                    return
                }
                Movement(host: self).showFermi(animated: true)
            })
//            Movement(host: self).showLogin(animated: false)
        }
        else {
            Movement(host: self).showLogin(animated: false)
        }
    }

}
