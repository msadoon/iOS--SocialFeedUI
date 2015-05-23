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
    private var centerPoint:CGPoint = CGPointMake(50.0,50.0)
    private var writePostVC:CreatePostViewController?
    private var postArrayForDemoPurposes:[Post] = []
    init() {
       //this is a Singleton class used for common functions
    }

    func setArrayForDemoPurposes() {
        var SamplePost1:Post = Post(ID:1, numLikes:2, numComments:9, postContent:"Post Post Post Post Post Post Post Post Post Post", liked:true, color: ColorType.Teal, createdTime: "< 1 hour ago", createdCity: "Toronto")
        var SamplePost2:Post = Post(ID:2, numLikes:4, numComments:8, postContent:"Post 2", liked:false, color: ColorType.Yellow, createdTime: "17 hours ago", createdCity: "Toronto")
        var SamplePost3:Post = Post(ID:3, numLikes:1, numComments:4, postContent:"Post 3", liked:false, color: ColorType.Gray, createdTime: "11 hour2 ago", createdCity: "Toronto")
        var SamplePost4:Post = Post(ID:4, numLikes:2, numComments:7, postContent:"Post 4", liked:true, color: ColorType.LightBlue, createdTime: "< 1 hour ago", createdCity: "Toronto")
        var SamplePost5:Post = Post(ID:5, numLikes:5, numComments:3, postContent:"Post 5", liked:true, color: ColorType.DarkBlue, createdTime: "2015.05.19", createdCity: "Toronto")
        var SamplePost6:Post = Post(ID:6, numLikes:74, numComments:0, postContent:"Post 6",liked:false, color: ColorType.Purple, createdTime: "23 hours ago", createdCity: "Toronto")
        var SamplePost7:Post = Post(ID:7, numLikes:1, numComments:29, postContent:"Post 7", liked:false, color: ColorType.Orange, createdTime: "14 hour ago", createdCity: "Toronto")
        var SamplePost8:Post = Post(ID:8, numLikes:0, numComments:12, postContent:"Post 8", liked:true, color: ColorType.Pink, createdTime: "2015.04.19", createdCity: "Toronto")
        var SamplePost9:Post = Post(ID:9, numLikes:25, numComments:34, postContent:"Post 9", liked:false, color: ColorType.Teal, createdTime: "3 hours ago", createdCity: "Toronto")
        var SamplePost10:Post = Post(ID:10, numLikes:8, numComments:1, postContent:"Post 10", liked:true, color: ColorType.Yellow, createdTime: "8 hours ago", createdCity: "Toronto")
        
        postArrayForDemoPurposes = [SamplePost1, SamplePost2, SamplePost3, SamplePost4, SamplePost5,SamplePost6, SamplePost7, SamplePost8, SamplePost9, SamplePost10]

    }
    
    func addPostToDemoArray(post: Post?) {
        postArrayForDemoPurposes.append(post!)
    }
    
    func getArrayForDemoPurposes() -> [Post] {
        return postArrayForDemoPurposes
    }
    
    func setWriteVC(createPostVC: CreatePostViewController) {
        writePostVC = createPostVC
    }
    
    func getWriteVC() -> CreatePostViewController {
        return writePostVC!
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
    
    public func rollRandomColor() -> Int{
        return Int(arc4random_uniform(9))
    }
    
    public func returnColorForString(type:ColorType) -> UIColor
    {
        switch (type) {
        case ColorType.Teal:
            return UIColorFromRGB(0xC0F1E9)
        case ColorType.Yellow:
            return UIColorFromRGB(0xF1EEBE)
        case ColorType.Gray:
            return UIColorFromRGB(0xD6D6D6)
        case ColorType.LightBlue:
            return UIColorFromRGB(0xBDE3F0)
        case ColorType.Purple:
            return UIColorFromRGB(0xD9BDEF)
        case ColorType.Orange:
            return UIColorFromRGB(0xF0D5BD)
        case ColorType.Pink:
            return UIColorFromRGB(0xF0BDDB)
        default:
            return UIColorFromRGB(0xBDD2F0)
        }
    }
    
    public func degreesToRadians(degrees: Double) -> Double {
        return ((degrees*M_PI)/180)
    }
    
    func drawTeal() -> UIBezierPath {
        let teal:UIBezierPath? = UIBezierPath()
        teal?.moveToPoint(CGPointMake(50.0, 50.0))
        teal?.addLineToPoint(CGPointMake(50.0, 100.0))
        teal?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(90.0)), endAngle: CGFloat(degreesToRadians(135.0)), clockwise: true)
        teal?.closePath()
        return teal!
    }
    
    func drawYellow() -> UIBezierPath {
        let yellow:UIBezierPath? = UIBezierPath()
        yellow?.moveToPoint(CGPointMake(50.0, 50.0))
        yellow?.addLineToPoint(CGPointMake(15.0, 85.0))
        yellow?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(135.0)), endAngle: CGFloat(degreesToRadians(180.0)), clockwise: true)
        yellow?.closePath()
        return yellow!
    }
    
    func drawOrange() -> UIBezierPath {
        let orange:UIBezierPath? = UIBezierPath()
        orange?.moveToPoint(CGPointMake(50.0, 50.0))
        orange?.addLineToPoint(CGPointMake(0.0, 50.0))
        orange?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(180.0)), endAngle: CGFloat(degreesToRadians(225.0)), clockwise: true)
        orange?.closePath()
        return orange!
    }
    
    func drawPink() -> UIBezierPath {
        let pink:UIBezierPath? = UIBezierPath()
        pink?.moveToPoint(CGPointMake(50.0, 50.0))
        pink?.addLineToPoint(CGPointMake(15.0, 15.0))
        pink?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(225.0)), endAngle: CGFloat(degreesToRadians(270.0)), clockwise: true)
        pink?.closePath()
        return pink!
    }
    
    func drawGray() -> UIBezierPath {
        let gray:UIBezierPath? = UIBezierPath()
        gray?.moveToPoint(CGPointMake(50.0, 50.0))
        gray?.addLineToPoint(CGPointMake(50.0, 0.0))
        gray?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(270.0)), endAngle: CGFloat(degreesToRadians(315.0)), clockwise: true)
        gray?.closePath()
        return gray!
    }
    
    func drawPurple() -> UIBezierPath {
        let purple:UIBezierPath? = UIBezierPath()
        purple?.moveToPoint(CGPointMake(50.0, 50.0))
        purple?.addLineToPoint(CGPointMake(85.0, 15.0))
        purple?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(315.0)), endAngle: CGFloat(degreesToRadians(360.0)), clockwise: true)
        purple?.closePath()
        return purple!
    }
    
    func drawDarkBlue() -> UIBezierPath {
        let darkBlue:UIBezierPath? = UIBezierPath()
        darkBlue?.moveToPoint(CGPointMake(50.0, 50.0))
        darkBlue?.addLineToPoint(CGPointMake(100.0, 50.0))
        darkBlue?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(0.0)), endAngle: CGFloat(degreesToRadians(45.0)), clockwise: true)
        darkBlue?.closePath()
        return darkBlue!
    }
    
    func drawLightBlue() -> UIBezierPath {
        let lightBlue:UIBezierPath? = UIBezierPath()
        lightBlue?.moveToPoint(CGPointMake(50.0, 50.0))
        lightBlue?.addLineToPoint(CGPointMake(85.0, 85.0))
        lightBlue?.addArcWithCenter(centerPoint, radius: 50.0, startAngle: CGFloat(degreesToRadians(45.0)), endAngle: CGFloat(degreesToRadians(90.0)), clockwise: true)
        lightBlue?.closePath()
        return lightBlue!
    }
    
    func placeHolderTextCreatePost() -> String{
        return "Type here please!"
    }
    
    func addLikeToPost(ID:Int) {
        findPostWithID(ID).numLikes + 1
    }
    
    func subtractLikeToPost(ID:Int) {
        findPostWithID(ID).numLikes - 1
    }
    
    func findPostWithID(id:Int) -> Post {
        var i:Int = 0
        for (i = 0; i < getArrayForDemoPurposes().count ; i++) {
            if (getArrayForDemoPurposes()[i].ID == id) {
                return getArrayForDemoPurposes()[i]
            }
        }
        return findPostWithID(0)
    }
}