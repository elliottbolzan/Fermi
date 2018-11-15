//
//  PolyImageView.swift
//  PolyImageView
//
//  Created by Amornchai Kanokpullwad on 3/18/2558 BE.
//  Modified by Elliott Bolzan.
//  Copyright (c) 2558 Amornchai Kanokpullwad. All rights reserved.
//
import UIKit

class PolyImageView: UIView {
    
    private let sides: Int = 8
    private let inset: CGFloat = 10
    private let lineWidth: CGFloat = 4
    private let lineColor = Constants.border
    
    private var bezierPath: UIBezierPath?
    let imageView = UIImageView();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
    }
    
    override func draw(_ rect: CGRect) {
        if let path = bezierPath {
            lineColor.setStroke()
            path.stroke()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let rect = bounds;
        
        let insetRect = rect.insetBy(dx: inset, dy: inset)
        let radius = (insetRect.width > insetRect.height ? insetRect.height : insetRect.width) / 2.0
        let center = CGPoint(x: insetRect.midX, y: insetRect.midY)
        let radian = CGFloat(Double.pi * 2) / CGFloat(sides)
        let subRadius = radius * 0.4
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        let startPoint = CGPoint(x: center.x, y: center.y - radius)
        path.move(to: startPoint)
        
        // first curve
        let firstControlPoint = CGPoint(x: startPoint.x, y: startPoint.y + subRadius)
        path.addArc(withCenter: firstControlPoint,
                              radius: subRadius,
                              startAngle: CGFloat(3 * Double.pi / 2),
                              endAngle: CGFloat(3 * Double.pi / 2) - radian / 2,
                              clockwise: false)
        
        for i in 1...sides  {
            let θ = CGFloat(3 * Double.pi / 2) - CGFloat(i) * radian
            
            let point = CGPoint(
                x: center.x + radius * cos(θ),
                y: center.y + radius * sin(θ)
            )
            
            let controlPoint = CGPoint(
                x: center.x + (radius * 0.6) * cos(θ),
                y: center.y + (radius * 0.6) * sin(θ)
            )
            
            let deltaY = point.y - controlPoint.y
            let deltaX = point.x - controlPoint.x
            
            let radianDelta = atan2(deltaY, deltaX)
            
            let startAngle = radianDelta + (radian / 2)
            let endAngle = radianDelta - (radian / 2)
            
            path.addArc(withCenter: controlPoint, radius: subRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)

        }
        
        imageView.frame = bounds
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        imageView.layer.mask = maskLayer
        
        bezierPath = path
        setNeedsDisplay()
    }
    
}
