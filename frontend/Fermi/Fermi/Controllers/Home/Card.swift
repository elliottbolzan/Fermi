//
//  Card.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/15/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Card: UICollectionViewCell {
    
    @IBOutlet weak var container: UIView?
    @IBOutlet weak var header: UIView?
    @IBOutlet weak var profilePicture: PolyImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var company: UILabel?
    @IBOutlet weak var type: BadgeButton?
    @IBOutlet weak var fact: UITextView?
    
    override func awakeFromNib() {
        
        // Create drop-shadow.
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.7
        
        // Create rounded corners.
        container!.layer.masksToBounds = true
        container!.layer.borderWidth = 1
        container!.layer.cornerRadius = 4
        container!.layer.borderColor = Constants.border.cgColor
        
        // Create fact.
        self.type!.backgroundColor = UIColor.clear
        self.type!.layer.borderWidth = 1
        self.type!.setTitleColor(UIColor.black, for: .normal)
        setFact()

    }
    
    func setPerson(person: Person) {
        self.name!.text = person.name
        self.setTint(tint: State.shared.colorFor(id: person.id))
        person.profilePicture(completion: { image in
            self.profilePicture!.imageView.image = image
        })
    }
    
    func setTint(tint: UIColor) {
        self.type!.layer.borderColor = tint.cgColor
        self.header!.backgroundColor = tint
    }
    
    func setFact() {
        let string = "Refers more people than 78% of users."
        let attributed = NSMutableAttributedString(string: string)
        attributed.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size: 18)!, range: NSRange(location: 0, length: string.count))
        self.fact!.attributedText = attributed
    }
    
}
