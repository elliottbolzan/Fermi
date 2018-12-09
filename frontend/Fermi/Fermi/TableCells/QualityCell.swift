//
//  QualityCell.swift
//  Fermi
//
//  Created by Davis Booth on 11/30/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class QualityCell: UICollectionViewCell {

    @IBOutlet weak var visualPercentageView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let shapeLayer = CAShapeLayer()
    let percentLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        makeCircle()
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = .center
    }
    
    func load(quality: Quality) {
        percentLabel.text = String(quality.percentile) + "%"
        descriptionLabel.text = quality.name.capitalized
        animateCircle(to: CGFloat(quality.percentile))
    }
    
    func makeCircle() {
        let center = visualPercentageView.center
        let radiusSize = visualPercentageView.frame.height / 4
        let circularPath = UIBezierPath(arcCenter: center, radius: radiusSize, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.square
        visualPercentageView.layer.addSublayer(shapeLayer)
        populatePercentage(radius: radiusSize, centerView: center)
    }
    
    func populatePercentage(radius: CGFloat, centerView: CGPoint) {
        percentLabel.frame = CGRect(origin: center, size: CGSize(width: radius * 1.5, height: radius * 1.5))
        percentLabel.center = centerView
        percentLabel.textColor = .white
        percentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        percentLabel.textAlignment = .center
        visualPercentageView.addSubview(percentLabel)
    }
    
    func animateCircle(to: CGFloat) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = to / 100.00
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "animateStroke")
    }
    
}
