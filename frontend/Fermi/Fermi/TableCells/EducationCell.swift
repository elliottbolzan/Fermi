//
//  EducationCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/27/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class EducationCell: UITableViewCell {

    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }
    
    func load(education: Education) {
        universityLabel.text = education.university
        degreeLabel.text = education.degreeType
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let start = formatter.string(from: Date.fromBackendFormat(input: education.startdate))
        var end = ""
        if let enddate = education.enddate {
            end = formatter.string(from: Date.fromBackendFormat(input: enddate))
        }
        dateLabel.text = start + " – " + end
    }
    
}
