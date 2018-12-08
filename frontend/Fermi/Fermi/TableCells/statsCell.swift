//
//  statsCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/30/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class statsCell: UICollectionViewCell {

    @IBOutlet weak var visualPercentageView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    let shapeLayer = CAShapeLayer()
    let percentLabel = UILabel()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Makes circle
        makeCircle()
        
        // Set the description underneath circle.
        descriptionLabel.text = "Generosity"
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = .center
    }
    
    func makeCircle() {
        
        // Make the circle
        let center = visualPercentageView.center
        let radiusSize = visualPercentageView.frame.height/4
        let circularPath = UIBezierPath(arcCenter: center, radius: radiusSize, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        // Add circle to view
        visualPercentageView.layer.addSublayer(shapeLayer)
        
        // Populates the percentage to display inside the circle
        populatePercentage(radiusSize, centerView: center)
    }
    
    func populatePercentage(_ radius: CGFloat, centerView: CGPoint) {
        // Set up the percentage label inside the circle.
        percentLabel.frame = CGRect(origin: center, size: CGSize(width: radius*1.5, height: radius*1.5))
        percentLabel.center = centerView
        percentLabel.textColor = UIColor.white
        percentLabel.font = UIFont(name: "System-Bold", size: 17)
        percentLabel.textAlignment = .center
        
        // Add label to view
        visualPercentageView.addSubview(percentLabel)
    }
    
    
    func animateCircle(_ to : CGFloat) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = to/100.00
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "animateStroke")
        
    }
    
    
    func fullInit(_ percent: Int, description: String) {
        percentLabel.text = String(percent) + "%"
        descriptionLabel.text = description
        animateCircle(CGFloat(percent))
    }
    
}
