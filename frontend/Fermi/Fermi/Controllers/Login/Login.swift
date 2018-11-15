//
//  Login.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class Login: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var loginView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
    }
    
    func setupLoginButton() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.delegate = self
        loginView!.addSubview(loginButton)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(_):
            User.shared.load(completion: { person in
                guard person != nil else {
                    return
                }
                Movement(host: self).showFermi(animated: true)
            })
        default:
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        // Not used in this view.
    }

}
