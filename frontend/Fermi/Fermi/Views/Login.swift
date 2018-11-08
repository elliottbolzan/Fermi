//
//  Login.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Login: UIViewController {
    @IBOutlet weak var tintedView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tintedView.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
}
