//
//  BadgeButton.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/15/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class BadgeButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = Constants.dark
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel!.font = .systemFont(ofSize: 12)
        self.layer.cornerRadius = 5
    }

}
