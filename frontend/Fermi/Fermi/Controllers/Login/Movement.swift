//
//  Movement.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/14/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Movement {
    
    let host: UIViewController;
    let main: UIStoryboard;
    
    init(host: UIViewController) {
        self.host = host;
        main = UIStoryboard(name: "Main", bundle: nil)
    }
    
    func showLogin(animated: Bool) {
        let controller = main.instantiateViewController(withIdentifier: "login") as! Login
        host.present(controller, animated: animated, completion: nil)
    }
    
    func showFermi(animated: Bool) {
        let controller = main.instantiateViewController(withIdentifier: "fermi") as! Fermi
        host.present(controller, animated: animated, completion: nil)
    }
    
}
