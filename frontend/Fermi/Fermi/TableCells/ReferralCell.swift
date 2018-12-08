//
//  ReferralCell.swift
//  Fermi
//
//  Created by Davis Booth on 12/1/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class ReferralCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var profPic: UIImageView!
    
    var referral: Referral!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusButton.isEnabled = false
        statusButton.layer.cornerRadius = 5
        profPic.layer.cornerRadius = profPic.frame.size.height / 1.7
        profPic.contentMode = .scaleToFill
        profPic.clipsToBounds = true
    }
    
    func setup(referral: Referral) {
        self.referral = referral
        self.companyLabel.text = " » " + referral.company
        if referral.sender == User.shared.person!.name {
            setupMyReferral()
        }
        else {
            setupTheirReferral()
        }
    }
    
    func setupMyReferral() {
        self.nameLabel.text = referral.recipient
    }
    
    func setupTheirReferral() {
        self.nameLabel.text = referral.sender
        if referral.status == .requested {
            statusButton.isEnabled = true
            statusButton.backgroundColor = Constants.tint
            statusButton.tintColor = UIColor.white
            statusButton.setTitle("GRANT", for: .normal)
        }
        else {
            self.statusButton.setTitle(referral.status.rawValue.uppercased(), for: .normal)
            statusButton.setTitleColor(Constants.tint, for: .normal)
        }
    }
    
    @IBAction func statusButton(_ sender: Any) {
        statusButton.isEnabled = false
        statusButton.backgroundColor = UIColor.clear
        statusButton.setTitleColor(Constants.tint, for: .normal)
        statusButton.layer.borderColor = Constants.tint.cgColor
        statusButton.layer.borderWidth = 1
        statusButton.setTitle("GRANTED", for: .normal)
        // Accept response on Server.
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
}
