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
    @IBOutlet weak var majorLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fullInit(_ university: String, year: Int, major: String, majorType: String) {
        universityLabel.text = university
        classLabel.text = "Class of " + String(year)
        majorLabel.text = majorType + " in " + major
    }
    
    
    
}
