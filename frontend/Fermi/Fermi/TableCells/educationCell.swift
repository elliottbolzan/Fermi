//
//  educationCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/27/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class educationCell: UITableViewCell {

    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fullInit(_ university: String, year: Int, majorType: String) {
        universityLabel.text = majorType + " from " + university
        classLabel.text = "Class of " + String(year)
    }
    
    
    
}
