//
//  CreatePost.swift
//  JomJom
//
//  Created by Mubarak Sadoon on 2015-05-14.
//  Copyright (c) 2015 msadoon. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var utilityInstance:Utilities = Utilities.utilitiesInstance
    var buttonWidth:CGFloat?
    var heightOfNavBar:CGFloat?
    var postView:UIView?
    var textView:UIView?
    var scrollView:UIScrollView?
    var postLabel:UILabel?
    var colorPickerView:ColorPickerControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        configureNavigationBar()
        setupPostSpaceAndColorPicker()
        setupPostText()
        setupPostLabel()
        setupScrollView()
        setupKeyboardListeners()
        setupGestureRecognizers()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureNavigationBar() {
        //get rid of shadow in navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //set this up for underline and segment buttonsr
        buttonWidth = CGFloat(utilityInstance.getScreenWidth()/3)
        
        //left navigation bar button item
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        var groupChatButton:UIButton = UIButton(frame: CGRectMake(0, 0, 30.0, 30.0))
        groupChatButton.addTarget(self, action: "popBack", forControlEvents: UIControlEvents.TouchUpInside)
        groupChatButton.setBackgroundImage(UIImage(named: "2.1back"), forState: UIControlState.Normal)
        groupChatButton.setBackgroundImage(UIImage(named: "2.1back"), forState: UIControlState.Selected)
        groupChatButton.setBackgroundImage(UIImage(named: "2.1back"), forState: UIControlState.Highlighted)
        var newBarItemBackButton:UIBarButtonItem = UIBarButtonItem(customView: groupChatButton)
        self.navigationItem.leftBarButtonItem = newBarItemBackButton
        //right navigation bar button item
        var writePostButton:UIButton = UIButton(frame: CGRectMake(0, 0, 30.0, 30.0))
        writePostButton.addTarget(self, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
        writePostButton.setBackgroundImage(UIImage(named: "2.1writepost"), forState: UIControlState.Normal)
        writePostButton.setBackgroundImage(UIImage(named: "2.1writepost"), forState: UIControlState.Selected)
        writePostButton.setBackgroundImage(UIImage(named: "2.1writepost"), forState: UIControlState.Highlighted)
        var newBarItemRightButton:UIBarButtonItem = UIBarButtonItem(customView: writePostButton)
        self.navigationItem.rightBarButtonItem = newBarItemRightButton
        
        //custom titleview
        var updatingChatTitleButton:UIButton = UIButton(frame: CGRectMake(0, 0, 200, 34)) //50,34 bubble icon original size
        var imageInsets:UIEdgeInsets = UIEdgeInsetsMake(0, 21, 0, 10)
        var updatingChatTitleImage:UIImage =  UIImage(named: "1.0wechat_update")!
        updatingChatTitleImage = updatingChatTitleImage.resizableImageWithCapInsets(imageInsets)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Normal)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Highlighted)
        updatingChatTitleButton.setBackgroundImage(updatingChatTitleImage, forState: UIControlState.Selected)
        updatingChatTitleButton.addTarget(self, action: "popBack", forControlEvents: UIControlEvents.TouchUpInside)
        
        //add a UILabel to update text from server every 3 seconds
        var serverText:UILabel = UILabel(frame: CGRectMake(21, 0, 170, 34))
        serverText.text = "Group Chat"
        serverText.textAlignment = NSTextAlignment.Center
        updatingChatTitleButton.addSubview(serverText)
        
        self.navigationItem.titleView = updatingChatTitleButton
    }
    
    func popBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func pickRandomColor(num:Int) -> UIColor{
        var applyColor:UIColor
        switch (num) {
            case 0:
                applyColor = utilityInstance.returnColorForString(ColorType.Teal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1a"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Teal
            case 1:
                applyColor = utilityInstance.returnColorForString(ColorType.Yellow)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1b"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Yellow
            case 2:
                applyColor = utilityInstance.returnColorForString(ColorType.Gray)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1c"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Gray
            case 3:
                applyColor = utilityInstance.returnColorForString(ColorType.LightBlue)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1d"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.LightBlue
            case 4:
                applyColor = utilityInstance.returnColorForString(ColorType.Purple)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1e"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Purple
            case 5:
                applyColor = utilityInstance.returnColorForString(ColorType.Orange)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1f"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Orange
            case 6:
                applyColor = utilityInstance.returnColorForString(ColorType.Pink)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1g"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.Pink
            default:
                applyColor = utilityInstance.returnColorForString(ColorType.DarkBlue)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Normal)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Highlighted)
                colorPickerView!.setBackgroundImage(UIImage(named: "2.1h"), forState: UIControlState.Selected)
                colorPickerView?.currentColorName = ColorType.DarkBlue
        }
        return applyColor
    }
    
    func setupPostSpaceAndColorPicker() {
        var navbarHeight = self.navigationController?.navigationBar.bounds.height as CGFloat!
        heightOfNavBar = CGFloat(navbarHeight+20)
        postView = UIView(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!-44))
        colorPickerView = ColorPickerControl(frame: CGRectMake(20, postView!.frame.height-120, 100, 100))
        colorPickerView?.allBPaths = [utilityInstance.drawTeal(),utilityInstance.drawYellow(),utilityInstance.drawOrange(),utilityInstance.drawPink(),utilityInstance.drawGray(),utilityInstance.drawPurple(),utilityInstance.drawDarkBlue(), utilityInstance.drawLightBlue()]
        var randomColorNumber = utilityInstance.rollRandomColor()
        postView!.backgroundColor = pickRandomColor(randomColorNumber)

    }

    func setupPostLabel() {
        var postContentVerticalSpacer:CGFloat = CGFloat(utilityInstance.getScreenWidth()*0.3)
        var postContentHorizontalSpacer:CGFloat = CGFloat(CGFloat(utilityInstance.getScreenWidth()) - CGFloat(213))*0.5
        postLabel = UILabel(frame: CGRectMake(postContentHorizontalSpacer, postContentVerticalSpacer, CGFloat(213), CGFloat(153)))//same height as the cell post content label (check xib)
        postLabel?.numberOfLines = 0
        postLabel?.backgroundColor = UIColor.redColor()
        
    }
    
    func setupPostText() {
        textView = UIView(frame: CGRectMake(0, postView!.frame.height, CGFloat(utilityInstance.getScreenWidth()), 44))
        textView!.backgroundColor = utilityInstance.UIColorFromRGB(0xCBD6DD)
        
        var textBox:UITextField = UITextField(frame: CGRectMake(15, 9.5, CGFloat(utilityInstance.getScreenWidth()/1.30), 25))
        textBox.addTarget(self, action: "textDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        textBox.borderStyle = UITextBorderStyle.RoundedRect
        textBox.backgroundColor = UIColor.whiteColor()
        textBox.delegate = self
        var prefSendButtonWidth:CGFloat = CGFloat(utilityInstance.getScreenWidth()/10)
        var prefSendButtonHeight:CGFloat = prefSendButtonWidth*0.85185
        var sendButton:UIButton = UIButton(frame: CGRectMake(textBox.frame.width+32, 9.5, prefSendButtonHeight, 25))
        sendButton.setBackgroundImage(UIImage(named:"2.1post"), forState: UIControlState.Normal)
        sendButton.setBackgroundImage(UIImage(named:"2.1post"), forState: UIControlState.Selected)
        sendButton.setBackgroundImage(UIImage(named:"2.1post"), forState: UIControlState.Highlighted)
        
        textView!.addSubview(sendButton)
        textView!.addSubview(textBox)
    }
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!))
        scrollView!.contentSize = CGSizeMake(CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!)
        scrollView!.bounces = false
        scrollView?.delaysContentTouches = false
        scrollView?.addSubview(postView!)
        scrollView?.addSubview(postLabel!)
        scrollView?.addSubview(textView!)
        scrollView?.addSubview(colorPickerView!)

        self.view.addSubview(scrollView!)
    }
    
    func setupKeyboardListeners() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setupGestureRecognizers() {
        var dismissKeyboard:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "keyboardDismissTap:")
        dismissKeyboard.delegate = self
        self.view.addGestureRecognizer(dismissKeyboard)
    }
    
    //MARK: Keyboard methods
    
    func keyboardWillShow(notif:NSNotification) {
        let keyboardFrame = view.convertRect(notif.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue(), fromView:nil)
        scrollView!.frame = CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!-keyboardFrame.height)
        scrollView?.contentOffset = CGPointMake(0, keyboardFrame.size.height)
    }
    
    func keyboardWillHide(notif: NSNotification) {
        let keyboardFrame = view.convertRect(notif.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue(), fromView:nil)
        scrollView!.frame = CGRectMake(0, 0, CGFloat(utilityInstance.getScreenWidth()), CGFloat(utilityInstance.getScreenHeight())-heightOfNavBar!+keyboardFrame.height)
    }
    
    //MARK: Gesture Recognizer Methods
    
    func keyboardDismissTap(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: TextField Event Listener
    
    func textDidChange(textField:UITextField) {
        postLabel?.text = textField.text //140 character
    }
    
    //MARK: TextField Delegate Methods
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //resize view
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        //resize view
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
