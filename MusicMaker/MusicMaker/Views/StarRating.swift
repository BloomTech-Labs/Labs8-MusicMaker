//
//  StarRating.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class StarRating: UIControl {

    
    // MARK: - Properties
    var value = 1
    private var componentDimension: CGFloat = 40.0
    private var componentCount = 3
    private var componentActiveColor = UIColor.black
    private var componentInactiveColor = UIColor.gray
    
    var stars = [UILabel]()
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setup()
    }
    
    func setup() {
        let star1 = UILabel(frame: CGRect(x: 0, y: 0, width: componentDimension, height: componentDimension))
        star1.text = "★"
        star1.tag = 1
        star1.font = star1.font.withSize(32)
        star1.textColor = componentActiveColor
        star1.textAlignment = .center
        stars.append(star1)
        let star2 = UILabel(frame: CGRect(x: componentDimension, y: 0, width: componentDimension, height: componentDimension))
        star2.text = "★"
        star2.tag = 2
        star2.font = star2.font.withSize(32)
        star2.textColor = componentInactiveColor
        star2.textAlignment = .center
        stars.append(star2)
        let star3 = UILabel(frame: CGRect(x: componentDimension * 2, y: 0, width: componentDimension, height: componentDimension))
        star3.text = "★"
        star3.tag = 3
        star3.font = star3.font.withSize(32)
        star3.textColor = componentInactiveColor
        star3.textAlignment = .center
        stars.append(star3)
        
        
        self.addSubview(star1)
        self.addSubview(star2)
        self.addSubview(star3)
        
        
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        sendActions(for: [.touchDown, .valueChanged])
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if self.bounds.contains(touchPoint) {
            sendActions(for: [.touchDragInside, .valueChanged])
            updateValue(at: touch)
        } else {
            sendActions(for: .touchDragOutside)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event) }
        
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        
        if self.bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside, .valueChanged])
            updateValue(at: touch)
        } else {
            sendActions(for: .touchUpOutside)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    func updateValue(at touch: UITouch) {
        for starLabel in stars {
            let touchPoint = touch.location(in: starLabel)
            if self.bounds.contains(touchPoint) {
                value = starLabel.tag
                starLabel.textColor = componentActiveColor
                sendActions(for: .valueChanged)
            } else {
                starLabel.textColor = componentInactiveColor
            }
        }
    }
}
