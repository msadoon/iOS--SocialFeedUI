//
//  GroupChatLabel.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-25.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class GroupChatLabelLine:UILabel {
    
    var currentStrokePath:UIBezierPath?
    var utilitiesInstance:Utilities = Utilities.utilitiesInstance
    var labelToAdd:UILabel? = UILabel()
    var strokeFillColor: UIColor? = UIColor()
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextAddPath(context, currentStrokePath?.CGPath)
        CGContextSetStrokeColorWithColor(context, strokeFillColor!.CGColor)
        CGContextSetLineWidth(context, 1.0)
        CGContextStrokePath(context)
        self.addSubview(labelToAdd!)
    }
    
}