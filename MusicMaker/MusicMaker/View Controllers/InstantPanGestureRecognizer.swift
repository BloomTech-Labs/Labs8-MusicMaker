//
//  InstantPanGestureRecognizer.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/20/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
    
}
