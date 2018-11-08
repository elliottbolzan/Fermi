//
//  Home.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit
import Alamofire

class Home: UIViewController {
    
    var data: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    func refresh() {
        data = []
        let uri = Constants.host + "example"
        Alamofire.request(uri, method: .get, parameters: nil, headers: nil).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print("error")
                return
            }
            guard let response = response.result.value as? [[String: Any]] else {
                print("error")
                return
            }
            for entry in response {
                guard let person = Person(json: entry) else {
                    print("error")
                    return
                }
                self.data.append(person)
            }
        }
    }

}
