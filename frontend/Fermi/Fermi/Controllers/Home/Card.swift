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
    @IBOutlet weak var occupation: UILabel?
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

    }
    
    func setPerson(person: Person) {
        let tint = State.shared.colorFor(id: person.id)
        self.name!.text = person.name
        self.setOccupation(person: person)
        self.setTint(tint: tint)
        self.setType(person: person, tint: tint)
        self.setFact(person: person)
        person.profilePicture(completion: { image in
            self.profilePicture!.imageView.image = image
        })
    }
    
    func setOccupation(person: Person) {
        var value = ""
        var attributed: NSMutableAttributedString
        if person.experience.count > 0 {
            value = "Works at " + person.experience.first!.company
            attributed = NSMutableAttributedString(string: value)
            attributed.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 18)!, range: NSRange(location: 9, length: value.count - 9))
        }
        else {
            value = "Seeking Employment"
            attributed = NSMutableAttributedString(string: value)
        }
        attributed.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue", size: 18)!, range: NSRange(location: 0, length: value.count))
        self.occupation!.attributedText = attributed
    }
    
    func setTint(tint: UIColor) {
        self.type!.layer.borderColor = tint.cgColor
        self.header!.backgroundColor = tint
    }
    
    func setType(person: Person, tint: UIColor) {
        let quality = person.mostInterestingQuality()
        let adjective = Constants.factAdjectives[quality.name]!
        let attributed = NSMutableAttributedString(string: adjective)
        if quality.percentile < 50 {
            attributed.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: adjective.count))
        }
        attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: adjective.count))
        attributed.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size: 14)!, range: NSRange(location: 0, length: adjective.count))
        self.type!.setAttributedTitle(attributed, for: .normal)
        self.type!.setAttributedTitle(attributed, for: .highlighted)
    }
    
    func setFact(person: Person) {
        let fact = person.fact()
        let attributed = NSMutableAttributedString(string: fact)
        attributed.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size: 18)!, range: NSRange(location: 0, length: fact.count))
        self.fact!.attributedText = attributed
    }
    
}
