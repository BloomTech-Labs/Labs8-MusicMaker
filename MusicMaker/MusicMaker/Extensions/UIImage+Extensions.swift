//
//  UIImage+Extensions.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/26/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //Sets the imageview's image to a circle with the name's initials in it
    func createInitialsImage(for name: String?, backgroundColor: UIColor) {
        
        let scale = Float(UIScreen.main.scale)
        var size = bounds.size
        
        if contentMode == .scaleAspectFit || contentMode == .scaleAspectFill {
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        
        let context = UIGraphicsGetCurrentContext()
        

        let path = CGPath(ellipseIn: bounds, transform: nil)
        context?.addPath(path)
        context?.clip()
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
    
        
        if let initials = name?.initials {
            print("TEST")
            print(self.frame.height)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.frame.height / 1.7)]
            
            let textSize = initials.size(withAttributes: attributes)
            let bounds = self.bounds
            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height)
            
            initials.draw(in: rect, withAttributes: attributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = image
    }
    
    func returnImageForInitials(for name: String?, backgroundColor: UIColor) -> UIImage? {
        
        let scale = Float(UIScreen.main.scale)
        var size = bounds.size
        
        if contentMode == .scaleAspectFit || contentMode == .scaleAspectFill {
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        
        let context = UIGraphicsGetCurrentContext()
        
        
        let path = CGPath(ellipseIn: bounds, transform: nil)
        context?.addPath(path)
        context?.clip()
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        
        if let initials = name?.initials {
            print("TEST")
            print(self.frame.height)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.frame.height / 1.7)]
            
            let textSize = initials.size(withAttributes: attributes)
            let bounds = self.bounds
            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height)
            
            initials.draw(in: rect, withAttributes: attributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
