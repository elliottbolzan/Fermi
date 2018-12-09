//
//  AddCell.swift
//  Fermi
//
//  Created by Davis Booth on 12/8/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class AddCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = UIColor.clear
        self.button.setTitleColor(UIColor.white, for: .normal)
        self.button.contentHorizontalAlignment = .center
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }

}
