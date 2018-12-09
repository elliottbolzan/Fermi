//
//  experienceCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/27/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class experienceCell: UITableViewCell {

    @IBOutlet weak var viewingStack: UIStackView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        companyLabel.textColor = UIColor.white
        dateLabel.textColor = UIColor.white
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fullInit(_ company: String, date: [String], position: String) {
        companyLabel.text = position + "\n" + company
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss zzz"
        let date1 = dateFormatter.date(from: date[0])
        if date[1] == "present" {
            dateFormatter.dateFormat = "MMM y"
            let dateFinal1 = dateFormatter.string(from: date1!)
            dateLabel.text = dateFinal1 + "-present"
        }
        else {
            let date2 = dateFormatter.date(from: date[1])
            dateFormatter.dateFormat = "MMM y"
            let dateFinal1 = dateFormatter.string(from: date1!)
            let dateFinal2 = dateFormatter.string(from: date2!)
            dateLabel.text = dateFinal1 + "-" + dateFinal2
        }
    }
    
}
