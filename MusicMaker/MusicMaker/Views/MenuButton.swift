//
//  MenuButton.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/19/18.
//  Copyright © 2018 Vuk. All rights reserved.
//


import UIKit

class MenuButton: UIButton {
    
    let firstLineShape = CAShapeLayer()
    var firstLinePath = UIBezierPath()
    var circleBounds: CGRect!
    let halfTheLineLength: CGFloat = sqrt(112.5)
    
    
    
    let circularPath = UIBezierPath(arcCenter: CGPoint(x: 15, y: 15), radius: 15, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
    
    
    let secondLineShape = CAShapeLayer()
    let secondLinePath = UIBezierPath()
    
    let thirdLineShape = CAShapeLayer()
    let thirdLinePath = UIBezierPath()
    
    let lineColor = UIColor(red: 26/2550, green: 146/255, blue: 233/255, alpha: 1.0).cgColor
    let lineWidth: CGFloat = 4.0
    let animiationDuration: CFTimeInterval = 0.5
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        circleBounds = circularPath.bounds
        print(circleBounds)
        firstLinePath.move(to: CGPoint(x: 15 - halfTheLineLength, y: 15 - halfTheLineLength))
        firstLinePath.addLine(to: CGPoint(x: 15 + halfTheLineLength, y: 15 - halfTheLineLength))
        firstLineShape.path = firstLinePath.cgPath
        firstLineShape.lineWidth = lineWidth
        firstLineShape.strokeColor = lineColor
        firstLineShape.lineCap = .round
        
        self.layer.addSublayer(firstLineShape)
        
        secondLinePath.move(to: CGPoint(x: 15 - halfTheLineLength, y: 15))
        secondLinePath.addLine(to: CGPoint(x: 15 + halfTheLineLength, y: 15))
        secondLineShape.path = secondLinePath.cgPath
        secondLineShape.lineWidth = lineWidth
        secondLineShape.strokeColor = lineColor
        secondLineShape.lineCap = .round
        self.layer.addSublayer(secondLineShape)
        
        thirdLinePath.move(to: CGPoint(x: 15 - halfTheLineLength, y: 15 + halfTheLineLength))
        thirdLinePath.addLine(to: CGPoint(x: 15 + halfTheLineLength, y: 15 + halfTheLineLength))
        thirdLineShape.path = thirdLinePath.cgPath
        thirdLineShape.lineWidth = lineWidth
        thirdLineShape.strokeColor = lineColor
        thirdLineShape.lineCap = .round
        
        self.layer.addSublayer(thirdLineShape)
        
        
    }
    
    func animateToX() {
        let firstLineAnimateToX = UIBezierPath()
        firstLineAnimateToX.move(to: CGPoint(x: 15 - halfTheLineLength, y: 15 - halfTheLineLength))
        firstLineAnimateToX.addLine(to: CGPoint(x: 15 + halfTheLineLength, y: 15 + halfTheLineLength))
        
        let firstLineAnimation = CABasicAnimation(keyPath: "path")
        firstLineAnimation.toValue = firstLineAnimateToX.cgPath
        firstLineAnimation.duration = animiationDuration
        
        firstLineAnimation.isRemovedOnCompletion = false
        firstLineAnimation.fillMode = .forwards
        firstLineShape.add(firstLineAnimation, forKey: "pathAnimation")
        
        let thirdLineAnimatedPath = UIBezierPath()
        thirdLineAnimatedPath.move(to: CGPoint(x: 15 - halfTheLineLength, y: 15 + halfTheLineLength))
        thirdLineAnimatedPath.addLine(to: CGPoint(x: 15 + halfTheLineLength, y: 15 - halfTheLineLength))
        
        let thirdLineAnimation = CABasicAnimation(keyPath: "path")
        thirdLineAnimation.toValue = thirdLineAnimatedPath.cgPath
        thirdLineAnimation.duration = animiationDuration
        thirdLineAnimation.isRemovedOnCompletion = false
        thirdLineAnimation.fillMode = .forwards
        thirdLineShape.add(thirdLineAnimation, forKey: "pathAnimation")
        
        
        
        let circleAnimation = CABasicAnimation(keyPath: "path")
        circleAnimation.toValue = circularPath.cgPath
        circleAnimation.duration = animiationDuration
        circleAnimation.isRemovedOnCompletion = false
        circleAnimation.fillMode = .forwards
        secondLineShape.fillColor = UIColor.clear.cgColor
        secondLineShape.add(circleAnimation, forKey: "pathAnimation")
        
        
        
    }
    
    func animateToMenu() {
     
        let firstLineMenuAnimation = CABasicAnimation(keyPath: "path")
        firstLineMenuAnimation.toValue = firstLinePath.cgPath
        firstLineMenuAnimation.duration = 0.5
        firstLineMenuAnimation.isRemovedOnCompletion = false
        firstLineMenuAnimation.fillMode = .forwards
        firstLineShape.add(firstLineMenuAnimation, forKey: "pathAnimationToMenu")
        
      
        
        let thirdLineMenuAnimation = CABasicAnimation(keyPath: "path")
        thirdLineMenuAnimation.toValue = thirdLinePath.cgPath
        thirdLineMenuAnimation.duration = 0.5
        thirdLineMenuAnimation.isRemovedOnCompletion = false
        thirdLineMenuAnimation.fillMode = .forwards
        thirdLineShape.add(thirdLineMenuAnimation, forKey: "pathAnimationToMenu")
     
        let secondLineMenuAnimation = CABasicAnimation(keyPath: "path")
        secondLineMenuAnimation.toValue = secondLinePath.cgPath
        secondLineMenuAnimation.duration = 0.5
        secondLineMenuAnimation.isRemovedOnCompletion = false
        secondLineMenuAnimation.fillMode = .forwards
        secondLineShape.add(secondLineMenuAnimation, forKey: "pathAnimationToMenu")
        
    }
    
    
}

