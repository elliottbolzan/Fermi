//
//  addExperience.swift
//  Fermi
//
//  Created by Davis Booth on 12/8/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class addExperience: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = UIColor.clear
        // Initialization code
    }
    
    func fullInit(_ label: String) {
        let str = "+ " + label
        self.button.setTitle(str, for: .normal)
        self.button.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    @IBAction func button(_ sender: Any) {
        print("hello")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
