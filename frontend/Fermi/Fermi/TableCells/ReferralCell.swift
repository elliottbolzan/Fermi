//
//  ReferralCell.swift
//  Fermi
//
//  Created by Davis Booth on 12/1/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class ReferralCell: UITableViewCell {
    
    var controller: Referrals!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var profilePicture: PolyImageView!
    
    var referral: Referral!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusButton.isEnabled = false
        statusButton.layer.cornerRadius = 5
    }
    
    func setup(controller: Referrals, referral: Referral) {
        self.controller = controller
        self.referral = referral
        //self.companyLabel.text = " » " + referral.company
        if referral.iAmSender() {
            // I sent it.
            setupTheirReferral()
        }
        else {
            // They sent it.
            setupMyReferral()
        }
    }
    
    func setupTheirReferral() {
        self.nameLabel.text = referral.recipient
        self.companyLabel.text = " » " + referral.company
        Server.profilePicture(id: referral.recipientId, completion: { image in
            self.profilePicture.imageView.image = image
        })
        if referral.status == .requested {
            statusButton.isEnabled = true
            statusButton.setTitle("GRANT", for: .normal)
            statusButton.setTitleColor(UIColor.white, for: .normal)
            statusButton.backgroundColor = Constants.tint
        }
        else {
            self.statusButton.setTitle(referral.status.rawValue.uppercased(), for: .normal)
            statusButton.setTitleColor(Constants.tint, for: .normal)
            statusButton.backgroundColor = UIColor.clear
        }
    }
    
    func setupMyReferral() {
        self.nameLabel.text = referral.company
        self.companyLabel.text = " from " + referral.sender
        Server.profilePicture(id: referral.senderId, completion: { image in
            self.profilePicture.imageView.image = image
        })
        if referral.status == .granted {
            statusButton.isEnabled = true
            statusButton.setTitle("UPDATE", for: .normal)
            statusButton.setTitleColor(UIColor.white, for: .normal)
            statusButton.backgroundColor = Constants.tint
        }
        else {
            self.statusButton.setTitle(referral.status.rawValue.uppercased(), for: .normal)
            statusButton.setTitleColor(Constants.tint, for: .normal)
            statusButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func statusButton(_ sender: Any) {
        if referral.iAmSender() {
            grantedReferral()
        }
        else {
            updatingStatus()
        }
    }
    
    func grantedReferral() {
        referral.status = Status.granted
        changeStatus()
    }
    
    func updatingStatus() {
        let alert = UIAlertController(title: "Did you get an offer from " + referral.company + "?", message: "Let " + referral.sender + " know by updating this referral's status.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.referral.status = Status.offered
            self.changeStatus()

        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            self.referral.status = Status.rejected
            self.changeStatus()

        }))
        alert.addAction(UIAlertAction(title: "Don't Know Yet", style: .cancel, handler: nil))
        self.controller.present(alert, animated: true)
    }
    
    func changeStatus() {
        Server.updateReferral(referral: referral, completion: { referral in })
        statusButton.isEnabled = false
        statusButton.backgroundColor = UIColor.clear
        statusButton.setTitleColor(Constants.tint, for: .normal)
        statusButton.setTitle(referral.status.rawValue.uppercased(), for: .normal)
    }
        
}
