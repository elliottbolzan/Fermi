//
//  experienceCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/27/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class experienceCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fullInit(_ company: NSMutableAttributedString, date: [String], position: NSMutableAttributedString) {
        position.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:position.string.count))
        position.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold), range: NSRange(location:0,length:position.string.count))
        
        company.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSRange(location:0,length: company.string.count))
        company.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.medium), range: NSRange(location:0,length: company.string.count))
        
        let result = NSMutableAttributedString()
        result.append(position)
        result.append(NSMutableAttributedString(string: "\n"))
        result.append(company)
        companyLabel.attributedText = result
        dateLabel.text = date[0] + "-" + date[1]
    }
    
}
