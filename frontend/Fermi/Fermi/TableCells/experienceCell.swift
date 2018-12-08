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
    
    @IBOutlet weak var editingStack: UIStackView!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    var isInEditMode: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        companyLabel.textColor = UIColor.white
        dateLabel.textColor = UIColor.white
        
        if isInEditMode {
            setUpEditing()
        }
        else {
            setUpViewing()
        }
    }
    
    func setUpEditing() {
        editingStack.isHidden = false
        viewingStack.isHidden = true
    }
    
    func setUpViewing() {
        editingStack.isHidden = true
        viewingStack.isHidden = false
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fullInit(_ company: String, date: [String], position: String) {
        companyLabel.text = position + "\n" + company
        dateLabel.text = date[0] + "-" + date[1]
        
        dateTextField.text = date[0]
        endDateTextField.text = date[1]
        companyTextField.text = company
        positionTextField.text = position
    }
    
}
