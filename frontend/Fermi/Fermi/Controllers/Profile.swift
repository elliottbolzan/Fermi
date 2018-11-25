//
//  Profile.swift
//  Fermi
//
//  Created by Davis Booth on 11/3/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    // Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var horizontalStack: UIStackView!
    @IBOutlet weak var givenLabel: UILabel!
    @IBOutlet weak var receivedLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // person variable
    var person: Person?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
    }

}
