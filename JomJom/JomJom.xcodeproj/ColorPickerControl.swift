//
//  ColorPickerControl.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-16.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class ColorPickerControl:UIButton {
    
    var utilityInstance:Utilities = Utilities.utilitiesInstance
    var currentColorName:ColorType?
    var currentBPath:UIBezierPath?
    var allBPaths:[UIBezierPath?] = []

    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        checkColorBasedOnBezierPath(touch)
        return super.beginTrackingWithTouch(touch, withEvent: event)
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        checkColorBasedOnBezierPath(touch)
        return super.continueTrackingWithTouch(touch, withEvent: event)
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        checkColorBasedOnBezierPath(touch)
        return super.endTrackingWithTouch(touch, withEvent: event)
    }
    
    override func drawRect(rect: CGRect) {
        let context:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, currentBPath?.CGPath)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(context, 1.0)
        CGContextStrokePath(context)
    }
    
    private func checkColorBasedOnBezierPath(touch: UITouch) {
        if (allBPaths[0]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Selected)
            
        } else if (allBPaths[1]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Selected)
        } else if (allBPaths[2]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Selected)
        } else if (allBPaths[3]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Selected)
        } else if (allBPaths[4]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Selected)
        } else if (allBPaths[5]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Selected)
        } else if (allBPaths[6]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Selected)
        } else if (allBPaths[7]!.containsPoint(touch.locationInView(self))) {
            self.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Highlighted)
            self.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Selected)
        }
    }

    
}