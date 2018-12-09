//
//  ExperienceCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/27/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        companyLabel.textColor = UIColor.white
        dateLabel.textColor = UIColor.white
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }
    
    func load(experience: Experience) {
        companyLabel.text = experience.company
        positionLabel.text = experience.position
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let start = formatter.string(from: Date.fromBackendFormat(input: experience.startdate))
        var end = ""
        if let enddate = experience.enddate {
            end = formatter.string(from: Date.fromBackendFormat(input: enddate))
        }
        dateLabel.text = start + " – " + end
    }
    
}
