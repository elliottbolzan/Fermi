//
//  FirstViewController.swift
//  Fermi
//
//  Created by Davis Booth on 11/2/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import Alamofire

class Referrals: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Add URL headers and parameters
        Alamofire.request("", method: .get, parameters: nil, headers: nil).response { response in
            
            // TODO: Do something with the response
            print(response)
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

