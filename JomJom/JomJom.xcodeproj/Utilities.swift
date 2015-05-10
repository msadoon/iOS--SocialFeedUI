//
//  Utilities.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-05.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import Foundation
import UIKit

public class Utilities {
    static var utilitiesInstance = Utilities.init()
    private var mainAppColor = UIColor(red: 94.0/255.0, green: 169.0/255.0, blue: 186.0/255.0, alpha: 1)
    init() {
       //this is a Singleton class used for common functions
    }
    
    public func getAppColor()->UIColor
    {
        return mainAppColor
    }
    
    public func getScreenWidth() -> Float
    {
        return Float(UIScreen.mainScreen().bounds.width)
    }
    
    public func getScreenHeight() -> Float
    {
        return Float(UIScreen.mainScreen().bounds.height)
    }
    
    public func getStatusBarHeight() -> Float
    {
        return Float(UIApplication.sharedApplication().statusBarFrame.height)
    }
    
    public func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}