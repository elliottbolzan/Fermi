//
//  referralCell.swift
//  Fermi
//
//  Created by Davis Booth on 12/1/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class referralCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var profPic: UIImageView!
    
    
    // variable to determine if referral request has been accepted.
    var set = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set up the button's initial view
        statusButton.isEnabled = false
        statusButton.layer.cornerRadius = 4
        
        // Set up profile picture
        profPic.layer.cornerRadius = profPic.frame.size.height/1.7
        profPic.contentMode = .scaleToFill
        profPic.clipsToBounds = true
        
        // TODO : populate images properly based on user id or whatever is necessary
        
    }
    
    
    func fullInit(_ name: String, company: String, status: String) {
        
        // Set up name and company
        self.nameLabel.text = name
        self.companyLabel.text = " » " + company
        
        
        // Set up status button based on current status.
        if status == "Waiting for response" {      // If this is a request for a referral
            if !set {                           // If this invite has yes to be accepted
                statusButton.isEnabled = true
                statusButton.backgroundColor = UIColor(red:0.35, green:0.58, blue:0.67, alpha:1.0)
                statusButton.tintColor = UIColor.white
                statusButton.setTitle("ACCEPT", for: .normal)
                self.set = true
            }
            else {
                statusButton.setTitle("ACCEPTED", for: .normal)
            }
            
        }
        else {                                  // If this is not a request for referral
            self.statusButton.setTitle(status.uppercased(), for: .normal)
            statusButton.setTitleColor(UIColor(red:0.35, green:0.58, blue:0.67, alpha:1.0), for: .normal)
        }
    }
    
    @IBAction func statusButton(_ sender: Any) {
        
        // Change the graphics of the button if referral request accepted.
        statusButton.isEnabled = false
        statusButton.backgroundColor = UIColor.clear
        statusButton.setTitleColor(UIColor(red:0.35, green:0.58, blue:0.67, alpha:1.0), for: .normal)
        statusButton.layer.borderColor = UIColor(red:0.35, green:0.58, blue:0.67, alpha:1.0).cgColor
        statusButton.layer.borderWidth = 1
        statusButton.setTitle("ACCEPTED", for: .normal)
        
        
        // TODO: Fire response back that request has been accepted
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
