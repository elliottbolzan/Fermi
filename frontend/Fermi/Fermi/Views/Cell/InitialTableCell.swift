//
//  InitialTableCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class InitialTableCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //function that constructs the nib upon request from TableView
    func commonInit(pName: String, pId: Int, pEmail: String) {
        self.name.text = pName
        self.id.text = String(pId)
        self.email.text = pEmail
    }
    
}
